class Admin::SubscribersController < Admin::BaseController
  inherit_resources
  select_section [:subscribers]

  def new
    select_section [subscriber_type]
    build_resource
    resource.type = subscriber_type

    if resource.organization_owner?
      resource.build_own_organization
      resource.own_organization.build_subscription
      resource.orders.build
    else
      resource.build_subscription
      resource.orders.build
    end
  end

  def index
    respond_to do |format|
      format.html
      format.json { render json: AdminSubscribersDatatable.new(view_context) }
    end
  end

  def active
    respond_to do |format|
      format.html
      format.json { render json: AdminSubscribersActiveDatatable.new(view_context) }
    end
  end

  def suspended
    respond_to do |format|
      format.html
      format.json { render json: AdminSubscribersSuspendedDatatable.new(view_context) }
    end
  end

  def expired
    respond_to do |format|
      format.html
      format.json { render json: AdminSubscribersExpiredDatatable.new(view_context) }
    end
  end

  def csv
    columns = %w[last_name title district email subscription_requested_or_activated_at subscription_expires_at subscription_type status_in_business_terms]
    sort_by = columns[params[:order]["0"][:column].to_i]
    sort_direction = params[:order]["0"][:dir]
    csv = ::Domain::Subscriber::Reports::CSVBuilder::BySort.! sort_by, sort_direction
    file_name = "subscribers_#{I18n.l Time.zone.now, format: :for_report_CSV}"
    send_data csv, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{file_name}.csv"
  end

  def show
    subscription_type = resource.type
    case subscription_type
    when 'individual_account'
      @current_terms = TermsOfService.where(current: true, subscription_type: 'Individual').first
    when 'publisher_account'
      @current_terms = TermsOfService.where(current: true, subscription_type: 'Publisher').first
    when 'organization_member'
      @current_terms = TermsOfService.where(current: true, subscription_type: 'District/Campus').first
    when 'organizational_account'
      @current_terms = TermsOfService.where(current: true, subscription_type: 'District/Campus').first
    end

    @accepted_terms = Domain::Subscriber::Reports::AcceptedTerms::Builder.! resource
    @current_terms_are_accepted = @accepted_terms.select { |t| t.term_id == @current_terms.id}.first
    add_breadcrumb resource.name_or_email, '#'
  end

  def edit
    add_breadcrumb resource.full_name, '#'
  end

  def update
    if params[:subscriber][:subscription_attributes].present? && params[:subscriber][:subscription_attributes][:expire_at].present?
      date = Date.parse(params[:subscriber][:subscription_attributes][:expire_at])
      params[:subscriber][:subscription_attributes][:expire_at] =  date
    end

    if params[:subscriber][:password].present?
      result = resource.update_attributes(params[:subscriber])
    else
      result = resource.update_without_password(params[:subscriber])
    end

    if result
      unless resource.zoho_account_id.nil? || resource.zoho_account_id.empty?
        # Update CRM
        SubscriberProfileUpdateCRMAccountRecordWorker.perform_async(resource.id) unless resource.type == 'organization_member'
        unless resource.zoho_contact_id.nil? || resource.zoho_contact_id.empty?
          SubscriberUpdateCRMContactRecordWorker.perform_async(resource.id)
        end
        unless resource.zoho_potential_id.nil? || resource.zoho_potential_id.empty?
          SubscriberUpdateCRMPotentialRecordWorker.delay_for(2.seconds).perform_async(resource.id) unless resource.type == 'organization_member'
        end
      end

      flash[:success] = 'Subscriber updated successfully'
      redirect_to resource_path
    else
      render :edit
    end
  end

  def create
    build_resource
    resource.created_manually = true

    if resource.save_with_confirmation
      subscription = resource.current_subscription
      order = resource.last_order
      ::Domain::Order::Commands::UpdateBySubscription.! order, subscription

      unless resource.zoho_account_id.nil? || resource.zoho_account_id.empty?
        # Update CRM
        unless resource.zoho_contact_id.nil? || resource.zoho_contact_id.empty?
          SubscriberUpdateCRMContactRecordWorker.perform_async(resource.id)
        end
        SubscriberProfileUpdateCRMAccountRecordWorker.perform_async(resource.id) unless resource.type == 'organization_member'
      end

      resource.pending_manual!
      redirect_to collection_path
    else
      render :new
    end
  end

  def destroy
    if resource.organization_owner? && resource.own_organization.members.any?
      raise Mongoid::Errors::DeleteRestriction.new(resource, 'members')
    else
      destroy!
    end

  rescue Mongoid::Errors::DeleteRestriction => e
    flash[:error] = e.message
    redirect_to collection_path
  end

  def activate
    # run activate method
    if resource.current_subscription.activate
      unless resource.zoho_account_id.nil? || resource.zoho_account_id.empty?
        # Update CRM
        SubscriberProfileUpdateCRMAccountRecordWorker.delay_for(2.seconds).perform_async(resource.id)
        unless resource.zoho_potential_id.nil? || resource.zoho_potential_id.empty?
          SubscriberSetCRMPotentialStageWorker.delay_for(2.seconds).perform_async(resource.id)
        end
      end
      flash[:success] = 'Subscriber account was activated'
    else
      flash[:error] = resource.errors.full_messages.join(', ')
    end
    redirect_to :back
  end

  def suspend
    if resource.current_subscription.suspend
      unless resource.zoho_potential_id.nil? || resource.zoho_potential_id.empty?
        # Update CRM
        SubscriberSetCRMPotentialStageWorker.delay_for(2.seconds).perform_async(resource.id)
      end
      flash[:success] = 'Subscriber account was suspended'
    else
      flash[:error] = resource.current_subscription.errors.full_messages.join(', ')
    end
    redirect_to :back
  end

  def reinvite_member
    subscriber = Subscriber.where(email: params[:member_email]).first
    organization = Organization.where(id: subscriber.organization_id).first
    if organization.present?
      organization.member_email = params[:member_email]
      response = organization.reinvite_member!
      flash[:success] = response
    end

    redirect_to :back
  end

  protected

  add_breadcrumb 'Subscribers', :admin_subscribers_path
  add_breadcrumb 'New', '', only: [:new]

  def end_of_association_chain
    Subscriber.desc(:created_at)
  end

  def subscriber_type
    Subscriber.type.values.include?(params[:subscriber_type]) ? params[:subscriber_type] : 'individual_account'
  end
  helper_method :subscriber_type
end

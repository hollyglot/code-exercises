class Admin::PublishersController < Admin::BaseController
  inherit_resources
  select_section [:publishers, :new], only: :new

  before_filter :clear_password_if_blank, only: [:create, :update]

  def create
    create! { collection_path }
  end

  def index
    respond_to do |format|
      format.html
      format.json { render json: AdminPublishersDatatable.new(view_context) }
    end
  end

  def show
    @current_terms = TermsAndCondition.where(current: true).first

    @accepted_terms = Domain::Publisher::Reports::AcceptedTerms::Builder.! resource
    @current_terms_are_accepted = @accepted_terms.select { |t| t.term_id == @current_terms.id}.first
    add_breadcrumb resource.name, '#'
  end

  def edit
    add_breadcrumb resource.name, '#'
  end

  def update
    if params[resource_name][:password].present?
      result = resource.update_attributes(params[resource_name])
    else
      result = resource.update_without_password(params[resource_name])
    end

    if result
      flash[:success] = "#{resource_name.humanize.camelize} updated successfully"
      redirect_to collection_path
    else
      render :edit
    end
  end

protected

  add_breadcrumb 'Publishers', :admin_publishers_path
  add_breadcrumb 'New Publisher', '', only: [:new]

  def resource_name
    'publisher'
  end

  def clear_password_if_blank
    if params[:publisher].present? && params[:publisher][:password].blank?
      params[:publisher][:password] = nil
    end
  end

end

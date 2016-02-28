class Admin::OrganizationsController < Admin::BaseController
  inherit_resources
  select_section :organizations

  def index
    respond_to do |format|
      format.html
      format.json { render json: AdminOrganizationsDatatable.new(view_context) }
    end
  end

  def show
    add_breadcrumb resource.name, ''
  end

  def add_members
  end

  # Sends invitations to authorized users
  def invite_members
    if params[:organization][:members_emails].present?
      flash[:success] = "Processing invitations... You will receive a confirmation email soon."
      SubscriberAuthorizeMemberWorker.perform_async(resource.id, params)
    end

    redirect_to admin_organization_path(resource)
  end

  protected

  def collection
    if params[:by_name].present?
      Organization.by_name(params[:by_name])
    else
      Organization.page(params[:page]).per(50)
    end
  end

  add_breadcrumb 'Organizations', :admin_organizations_path

end

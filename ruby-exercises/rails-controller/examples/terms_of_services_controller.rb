class Admin::TermsOfServicesController < Admin::BaseController
  inherit_resources
  select_section [:terms_of_services, :list], except: :new
  select_section [:terms_of_services, :new], only: :new

  def show
    @subscribers_accepted = Domain::TermsOfService::Reports::SubscribersAccepted::Builder.! resource
    add_breadcrumb resource.version, '#'
  end

  def edit
    add_breadcrumb resource.version, '#'
  end

  def update
    update! do |success, failure|
      success.html do
        if params[:controller] == "admin/terms_of_services"
          redirect_to admin_terms_of_services_path
        else
          redirect_to admin_terms_of_service_path(resource)
        end
      end
      failure.html do
        flash[:error] = 'Missing required fields'
        render :edit
      end
    end
  end

  def create
    create! do |success, failure|
      success.html { redirect_to collection_path }
      failure.html do
        flash[:error] = 'Missing required fields'
        render :new
      end
    end
  end

  protected

  add_breadcrumb 'Terms of Service', :admin_terms_of_services_path
end
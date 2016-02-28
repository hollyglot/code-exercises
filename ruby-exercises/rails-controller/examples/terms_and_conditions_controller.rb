class Admin::TermsAndConditionsController < Admin::BaseController
  inherit_resources
  select_section [:terms_and_conditions, :list], except: :new
  select_section [:terms_and_conditions, :new], only: :new

  def show
    @publishers_accepted = Domain::TermsAndCondition::Reports::PublishersAccepted::Builder.! resource
    add_breadcrumb resource.version, '#'
  end

  def edit
    add_breadcrumb resource.version, '#'
  end

  def update
    update! do |success, failure|
      success.html do
        if params[:controller] == "admin/terms_and_conditions"
          redirect_to admin_terms_and_conditions_path
        else
          redirect_to admin_terms_and_condition_path(resource)
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

  add_breadcrumb 'Terms and Conditions', :admin_terms_and_conditions_path
end
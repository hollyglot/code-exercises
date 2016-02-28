class Admin::StandardsController < Admin::BaseController
  inherit_resources

  def create
    create! { collection_path }
  end

  def update
    update! { collection_path }
  end

  private

  add_breadcrumb 'Standards', :admin_standards_path
  add_breadcrumb 'New', '', only: [:new]
  add_breadcrumb 'Edit', '', only: [:edit]

end
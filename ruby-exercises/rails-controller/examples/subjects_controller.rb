class Admin::SubjectsController < Admin::BaseController
  inherit_resources
  select_section :subjects

  def show
    add_breadcrumb resource.title, '#'
  end

  def edit
    add_breadcrumb resource.title, '#'
  end

  def update
    update! { collection_path }
  end

  def create
    create! { collection_path }
  end

  protected

  add_breadcrumb 'Subjects', :admin_subjects_path
end
class Admin::OpenSourceProductsController < Admin::BaseController
  inherit_resources
  select_section [:open_source_products, :list], except: :new
  select_section [:open_source_products, :new],  only:   :new

  def show
    add_breadcrumb resource.title, '#'
  end

  def edit
    add_breadcrumb resource.title, '#'
  end

  def create
    create! { collection_path }
  end

  def update
    update! { collection_path }
  end

  def page_header
    'Open-Source Instructional Material or Online Course'
  end

  protected

  add_breadcrumb 'Open Source Products', :admin_open_source_products_path
  add_breadcrumb 'New', '', only: [:new]
end
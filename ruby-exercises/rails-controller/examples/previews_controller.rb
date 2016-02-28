class Admin::PreviewsController < Admin::BaseController
  layout 'subscriber'
  inherit_resources
  defaults resource_class: Product

  def show
    add_breadcrumb resource.title
  end
end
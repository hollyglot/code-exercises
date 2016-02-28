class Admin::OrdersController < Admin::BaseController
  inherit_resources
  select_section :orders

  def index
    respond_to do |format|
      format.html
      format.json  { render json: AdminOrdersDatatable.new(view_context) }
    end
  end

  protected

  def end_of_association_chain
    Order.paid.desc(:created_at)
  end

  add_breadcrumb 'Orders', :admin_orders_path
end
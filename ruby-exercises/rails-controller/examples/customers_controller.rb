class Admin::CustomersController < Admin::BaseController
  inherit_resources

  def index
    respond_to do |format|
      format.xlsx { xlsx_file_name file_name }
      format.html
    end
  end

  def new
    build_resource
  end

  def create
    create! do |success, failure|
      success.html { redirect_to admin_customer_path(resource) }
    end
  end

  def show
    add_breadcrumb resource.name, '#'
  end

  def edit
    add_breadcrumb resource.name, '#'
  end

  protected

  add_breadcrumb 'Customers', :admin_customers_path

  def file_name
    "Customers - #{Time.new.strftime '%m-%d-%Y'}"
  end

  def end_of_association_chain
    Customer.asc(:created_at)
  end


end

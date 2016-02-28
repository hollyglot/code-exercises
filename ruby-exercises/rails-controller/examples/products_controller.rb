class Admin::ProductsController < Admin::BaseController
  inherit_resources
  has_scope :by_publisher, only: [:index]
  has_scope :by_sme,       only: [:index]
  has_scope :by_er,        only: [:index]

  before_filter :set_validation_status, only: [:create, :update]

  select_section [:products, :list], except: :new
  select_section [:products, :new], only: :new

  def index
    @publisher = Publisher.find(params[:by_publisher]) if params[:by_publisher].present?
    @sme = SME.find(params[:by_sme]) if params[:by_sme].present?
    @er  = EditorialReviewer.find(params[:by_er]) if params[:by_er].present?

    respond_to do |format|
      format.html
      format.json { render json: AdminProductsDatatable.new(view_context) }
    end
  end

  def new
    build_resource
    resource.components.build unless resource.components.present?
    Product::MIN_COMPONENTS_COUNT.times { resource.customers.build }
  end

  def show
    add_breadcrumb resource.title, '#'
  end

  def edit
    add_breadcrumb resource.title, admin_product_path(resource)
  end

  def create
    er_director = Contact.where(position: 'Director of Editorial Review').first
    er = EditorialReviewer.where(email: er_director.email).first
    resource.editorial_reviewer_id = er.id
    create! do |success, failure|
      success.html { redirect_to collection_path }
      failure.html do
        resource.components.build unless resource.components.present?
        flash[:error] = 'Missing required fields'
        render :new
      end
    end
  end

  def update
    if resource.update_attributes(params[:product])
      resource.components.map(&:save)
      flash[:notice] = 'Product was successfully updated.'
      redirect_to [:admin, resource]
    else
      flash[:error] = 'Missing required fields'
      render :edit
    end
  end

  def send_to_publisher
    if resource.submit_for_publisher
      flash[:notice] = 'Preview period has started'
    else
      flash[:alert] = "Can't send product to Publisher"
    end
    redirect_to admin_product_path(resource)
  end


  def clone
    flash[:success] = "Creating #{resource.title}'s clone. It will be ready on the Products page in a few moments..."
    ProductCloneWorker.perform_async(resource.id)
    redirect_to :back
  end

  def stop_preview_period
    if resource.stop_preview_period
      flash[:notice] = 'Preview period was stopped.'
    else
      flash[:alert] = "Can't stop preview period."
    end
    redirect_to admin_product_path(resource)
  end

  def finish_preview_period
    if resource.finish_preview_period
      flash[:notice] = 'Preview period was finished.'
    else
      flash[:alert] = "Can't finish preview period."
    end
    redirect_to admin_product_path(resource)
  end

  def publish
    if resource.publish
      resource.update_indexes
      flash[:notice] = 'Product was published.'
    else
      flash[:alert] = "Can't publish product."
    end
    redirect_to admin_product_path(resource)
  end

  def unpublish
    if resource.unpublish
      resource.delete_index
      flash[:notice] = 'Product was unpublished.'
    else
      flash[:alert] = "Can't unpublish product."
    end
    redirect_to admin_product_path(resource)
  end

  def alignment_templates
    @data = resource.suggested_alignment_templates(params[:standard])
    respond_to do |format|
      format.json { render json: @data }
    end
  end

  def remind_about_preview_period
    if resource.remind_about_preview_period
      flash[:success] = "The reminder email about preview period to the #{resource.publisher.name} has been sent successfully!"
    else
      flash[:error]   = "Can't send email. Please contact support"
    end

    redirect_to :back
  end

  protected

  add_breadcrumb 'Products', :admin_products_path

  def collection
    if params[:h].present?
      @products ||= end_of_association_chain.recent
    else
      @products ||= end_of_association_chain.recent
    end
  end

  def set_validation_status
    build_resource unless params[:id].present?
    resource.state = 'submitted' if params[:commit] == 'Submit the product' && resource.new?
  end
end

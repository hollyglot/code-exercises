class Admin::PagesController < Admin::BaseController
  inherit_resources
  select_section :pages

  def new
    build_resource
    resource.parent_id = params[:parent_id]
    resource.static    = false
    resource.lock      = params[:lock]
    resource.position  = Page.where(id: params[:parent_id]).first.children.count
  end

  def update
    update! do |success, failure|
      success.html do
        redirect_to collection_path
      end
      success.json { render json: { success: true  } }

      failure.html { render :new }
    end
  end

  def edit
    add_breadcrumb resource.title, ''
  end

  def create
    create! { collection_path }
  end

  protected

  add_breadcrumb 'Pages', :admin_pages_path
  add_breadcrumb 'New', '', only: [:new]

  def collection
    end_of_association_chain.asc(:created_at)
  end
end
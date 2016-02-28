class Admin::ElementsController < Admin::BaseController
  inherit_resources
  actions :create, :update, :destroy, :new
  respond_to :json

  def new
    build_resource
    render json: resource
  end

  def create
    if params[:elements].present?
      params[:elements].each do |_,element_params|
        element = Element.new(element_params)
        element.id = element_params[:id]
        element.alignment_template_id = params[:alignment_template_id] if params[:alignment_template_id].present?

        if element_params[:parent_id].present?
          parent = Element.find(element_params[:parent_id])
          element.parent = parent
          element.position = parent.children.count+1 if element_params[:position].nil?
        end

        element.save!
      end
    end

    render json: { success: true }, status: 200
  end

  def update
    update! { return render json: resource }
  end

  def page_header
    "Breakout template - #{resource.alignment_template.title}"
  end
end

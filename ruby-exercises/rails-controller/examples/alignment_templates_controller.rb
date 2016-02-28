class Admin::AlignmentTemplatesController < Admin::BaseController
  inherit_resources
  actions :all
  select_section :alignment_templates

  def index
    respond_to do |format|
      format.json do
        @data = AlignmentTemplate.standards_tree
        render json: @data
      end
      format.html do
        render :index
      end
    end
  end

  def show
    add_breadcrumb resource.title, '#'

    respond_to do |format|
      format.json do
        @data = []
        collection = params[:node].present? ?  resource.sorted_elements_level(params[:node]) : resource.sorted_elements_level
        collection.each do |element|
          @data <<  { label:           element.content_with_label,
                      id:              element.id,
                      element_label:   element.label,
                      element_content: element.content,
                      element_state:   element.state,
                      element_additional_state: element.additional_state,
                      position:        element.position,
                      children:        ( element.has_children? ? process_children(element) : [])
          }
        end

        render json: @data
      end
      format.html { render :show }
    end

    add_breadcrumb resource.title, '#'
  end

  def update
    respond_to do |format|
      format.json do
        if params[:data].present?
          params[:data].each do |_,elements_params|
            update_elements_position(elements_params[:previous_parent_children]) if  elements_params[:previous_parent_children].present? && elements_params[:previous_parent_children].any?
            update_elements_position(elements_params[:current_parent_children]) if elements_params[:current_parent_children].present? && elements_params[:current_parent_children].any?

            current_element = Element.find(elements_params[:current_element])
            current_element.parent = Element.where(id: elements_params[:current_parent]).first
            current_element.save
          end
        end

        render json: resource
      end

      format.html { update! { collection_path } }
    end
  end

  def clone
    flash[:success] = "Creating #{resource.title}'s clone. It will be ready on the Alignment Templates page in a minute.."
    AlignmentTemplateCloneWorker.perform_async(resource.id)
    redirect_to :back
  end

  def print
    render :print, layout: false
  end

  def page_header
    'Alignment Templates'
  end

  protected

  add_breadcrumb 'Alignment Templates', :admin_alignment_templates_path

  def update_elements_position(collection)
    collection.each_with_index do |id, i|
      Element.find(id).set :position, i
    end
  end

  def process_children(parent)
    parent.children.asc(:position).map do |element|
      {
        label: element.content_with_label,
        id:    element.id,
        element_label: element.label,
        element_content: element.content,
        element_state:   element.state,
        element_additional_state: element.additional_state,
        position: element.position,
        children: ( element.has_children? ? process_children(element) : [])
      }
    end
  end
end

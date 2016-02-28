class Admin::AcademicInventoriesController < Admin::BaseController
  include HtmlHelper

  select_section :academic_inventories
  inherit_resources
  respond_to :js, only: [:update]
  actions :index, :show, :update, :new, :create, :destroy, :edit
  before_filter :load_product, only: [:new, :create]

  def index
    params["delete_button"] = "no"
    respond_to do |format|
      format.html
      format.json { render json: AdminAcademicInventoriesDatatable.new(view_context) }
    end
  end

  def deleting
    params["delete_button"] = "yes"
    respond_to do |format|
      format.html
      format.json { render json: AdminAcademicInventoriesDatatable.new(view_context) }
    end
  end

  def new
    adapt = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "adaptions").first
    @adaptions_questions = adapt.values_hash
    
    assess = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "assessments").first
    @assessments_questions = assess.values_hash
    
    align = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "alignment").first
    @alignment_questions = align.values_hash
    @alignment_collection = align.values_list
    
    ease = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "ease").first
    @ease_questions = ease.values_hash
    
    format = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "format").first
    @format_questions = format.values_hash
    @format_collection = format.values_list
    
    rigor = FormValue.all_of(:model_name => 'AcademicInventory', :attribute_name => 'rigor').first
    @rigor_questions = rigor.values_hash
    
    supports = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "supports").first
    @supports_questions = supports.values_hash

    grade = FormValue.all_of(:model_name => 'Component', :attribute_name => 'grade').first
    @grade_collection = grade.values_list
  end

  def create
    params["academic_inventory"]["product_id"] = params["product_id"]
    params["academic_inventory"]["criteria"].each do |criterion,answer_hash|
      answer_hash.each do |k,v|
        params["academic_inventory"]["criteria"][criterion][k] = v.to_i
      end
    end

    @academic_inventory = AcademicInventory.new(params["academic_inventory"])
    if @academic_inventory.save
      redirect_to admin_academic_inventory_url(@academic_inventory)
    else
      render :new
    end
  end

  def create_cloned
    original_inventory = resource
    product = Product.where(id: params["product_id"]).first
    clone_ai = original_inventory.clone
    clone_ai.created_at = nil
    clone_ai.updated_at = nil
    clone_ai.updated_date = nil
    clone_ai.product_id = params["product_id"]
    clone_ai.grade = product.first_component.grade
    clone_ai.subject = product.first_component.subject.title

    if clone_ai.save
      redirect_to admin_academic_inventory_url(clone_ai)
    else
      render :clone
    end
  end

  def clone
    
  end

  def edit
    adapt = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "adaptions").first
    @adaptions_questions = adapt.values_hash
    
    assess = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "assessments").first
    @assessments_questions = assess.values_hash
    
    align = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "alignment").first
    @alignment_questions = align.values_hash
    @alignment_collection = align.values_list
    
    ease = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "ease").first
    @ease_questions = ease.values_hash
    
    format = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "format").first
    @format_questions = format.values_hash
    @format_collection = format.values_list
    
    rigor = FormValue.all_of(:model_name => 'AcademicInventory', :attribute_name => 'rigor').first
    @rigor_questions = rigor.values_hash
    
    supports = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "supports").first
    @supports_questions = supports.values_hash

    grade = FormValue.all_of(:model_name => 'Component', :attribute_name => 'grade').first
    @grade_collection = grade.values_list
  end

  def update
    params["academic_inventory"]["criteria"].each do |criterion,answer_hash|
      answer_hash.each do |k,v|
        params["academic_inventory"]["criteria"][criterion][k] = v.to_i
      end
    end

    @academic_inventory = AcademicInventory.where(:id => params["id"]).first

    puts params["academic_inventory"]
    puts @academic_inventory.inspect
    if @academic_inventory.update_attributes(params["academic_inventory"])
      puts @academic_inventory.inspect
      redirect_to admin_academic_inventory_url(@academic_inventory)
    else
      render :edit
    end
  end

  def show
    @academic_inventory = resource
    @product = resource.product
    
    adapt = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "adaptions").first
    @adaptions_questions = adapt.values_hash
    
    assess = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "assessments").first
    @assessments_questions = assess.values_hash
    
    align = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "alignment").first
    @alignment_questions = align.values_hash
    @alignment_collection = align.values_list
    
    ease = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "ease").first
    @ease_questions = ease.values_hash
    
    format = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "format").first
    @format_questions = format.values_hash
    @format_collection = format.values_list
    
    rigor = FormValue.all_of(:model_name => 'AcademicInventory', :attribute_name => 'rigor').first
    @rigor_questions = rigor.values_hash
    
    supports = FormValue.all_of(:model_name => "AcademicInventory", :attribute_name => "supports").first
    @supports_questions = supports.values_hash

    grade = FormValue.all_of(:model_name => 'Component', :attribute_name => 'grade').first
    @grade_collection = grade.values_list
    
    add_breadcrumb resource.product_line, '#'
  end  

  def destroy
    academic_inventory = AcademicInventory.find(params[:id])

    academic_inventory.delete

    redirect_to :back
  end

  protected

  add_breadcrumb 'Academic Inventories', :admin_academic_inventories_path

  def load_product
    build_resource.product = Product.where(id: params[:product_id]).first
    redirect_to admin_root_path if resource.product.nil?
  end

  def can_destroy_resource?
    unless resource.can_admin_destroy? || permit_destroy
      redirect_to [:admin, resource], alert: "You can't delete the Academic Inventory because the product is live."
    end
  end

  

  def permit_destroy
    params[:ai_del].present?
  end
  helper_method :permit_destroy
end

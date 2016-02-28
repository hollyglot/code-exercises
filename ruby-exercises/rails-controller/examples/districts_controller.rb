class Admin::DistrictsController < Admin::BaseController
  inherit_resources
  has_scope :by_kind
  respond_to :json, :html
  select_section :districts

  def index
    respond_to do |format|
      format.html
      format.json  { render json: AdminEnrollmentDatatable.new(view_context) }
    end
  end

  def districts
    respond_to do |format|
      format.html
      format.json { render json: AdminEnrollmentDistrictsDatatable.new(view_context) }
    end
  end

  def public
    respond_to do |format|
      format.html
      format.json { render json: AdminEnrollmentPublicDatatable.new(view_context) }
    end
  end

  def school_lookup
    if params[:by_zip].present?
      respond_to do |format|
        format.json { render json: District.by_zip(params[:by_zip]) }
      end
    end
  end

  def private
    respond_to do |format|
      format.html
      format.json { render json: AdminEnrollmentPrivateDatatable.new(view_context) }
    end
  end

  def show
    add_breadcrumb resource.school_name, '#'
  end

  def edit
    add_breadcrumb resource.school_name, '#'
  end

  def update
    update! { collection_path }
  end

  protected

  add_breadcrumb 'Campuses and Districts', :admin_districts_path

  def collection
    if params[:by_zip].present?
      District.by_zip(params[:by_zip])
    else
      super.page(params[:page]).per(50)
    end
  end

  private

  def districts_kind
    params[:by_kind].present? && District.kind.values.include?(params[:by_kind]) ? params[:by_kind] : 'list'
  end
end
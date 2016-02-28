class Admin::AlignmentReportsController < Admin::BaseController
  include HtmlHelper

  layout :layout_by_action
  inherit_resources
  respond_to :js, only: [:update]
  actions :index, :show, :update, :new, :create, :destroy, :edit, :tool, :edit_file, :update_file
  before_filter :load_product,                             only: [:new, :create]
  before_filter :can_create_resource?,                     only: [:new, :create]
  before_filter :api_urls,                                 only: [:tool]
  before_filter :readable_fields,                          only: [:show, :tool]
  before_filter :writable_fields,                          only: [:show, :tool]
  before_filter :permit_only_writable_fields_in_breakouts, only: [:update]
  before_filter :can_destroy_resource?,                    only: [:destroy]
  before_filter :check_component_file,                     only: [:edit_file]

  def index
    params["delete_button"] = "no"
    respond_to do |format|
      format.html
      format.json { render json: AdminAlignmentReportsDatatable.new(view_context) }
    end
  end

  def deleting
    params["delete_button"] = "yes"
    respond_to do |format|
      format.html
      format.json { render json: AdminAlignmentReportsDatatable.new(view_context) }
    end
  end

  def show
    @alignment_report = resource
    @product = resource.product
    add_breadcrumb resource.title, '#'

    if resource.product.ready_for_publisher? || resource.product.preview_period?
      @preview_period = true
    end

    unless @alignment_report_table
      @alignment_report_table = ::Domain::AlignmentReport::Builders::DatatableBuilder.! resource
    end

    @show_aligned_to_standard = resource.alignment_template.standard.calculation_level != 0 ? true : false

    # comments options (stems)
    @non_aligned_stems = FormValue.all_of(:model_name => 'Breakout', :attribute_name => 'non-aligned-stems').first.values_list
    @pending_citation_stems = FormValue.all_of(:model_name => 'Breakout', :attribute_name => 'pending-citation-stems').first.values_list
    @although_not_listed_stems = FormValue.all_of(:model_name => 'Breakout', :attribute_name => 'although-not-listed-stems').first.values_list
    @ccss_math_stems = FormValue.all_of(:model_name => 'Breakout', :attribute_name => 'ccss-math-stems').first.values_list
    @response_stems = FormValue.all_of(:model_name => 'Breakout', :attribute_name => 'response-stems').first.values_list
    aligned_options = FormValue.all_of(:model_name => 'Breakout', :attribute_name => 'pages').first
    @aligned_collection = aligned_options.values_list
    @standard_heading = ::Domain::AlignmentReport::Builders::Standards::Heading.! @alignment_report

    if params[:all]
      last_page = params[:page].to_i - 1
      start_row = last_page * 10
      end_row = @alignment_report_table.length - 1
      @alignment_report_rows = Kaminari.paginate_array(@alignment_report_table[start_row..end_row]).page(1).per(@alignment_report_table[start_row..end_row].length)
    else
      @alignment_report_rows = Kaminari.paginate_array(@alignment_report_table).page(params[:page]).per(10)
    end
  end

  def check
    @alignment_report = resource
    @product = resource.product
    add_breadcrumb resource.title, admin_alignment_report_path(resource)

    @alignment_report_table = ::Domain::AlignmentReport::Builders::DatatableBuilder.! resource
    @show_aligned_to_standard = resource.alignment_template.standard.calculation_level != 0 ? true : false

    # comments options (stems)
    @non_aligned_stems = FormValue.all_of(:model_name => 'Breakout', :attribute_name => 'non-aligned-stems').first.values_list
    @pending_citation_stems = FormValue.all_of(:model_name => 'Breakout', :attribute_name => 'pending-citation-stems').first.values_list
    @although_not_listed_stems = FormValue.all_of(:model_name => 'Breakout', :attribute_name => 'although-not-listed-stems').first.values_list
    @ccss_math_stems = FormValue.all_of(:model_name => 'Breakout', :attribute_name => 'ccss-math-stems').first.values_list
    @response_stems = FormValue.all_of(:model_name => 'Breakout', :attribute_name => 'response-stems').first.values_list
    aligned_options = FormValue.all_of(:model_name => 'Breakout', :attribute_name => 'pages').first
    @aligned_collection = aligned_options.values_list
  end

  def csv
    @alignment_report = resource
    csv = ::Domain::AlignmentReport::Builders::CSVBuilder.! @alignment_report
    file_name = "#{@alignment_report.product.title.squish.downcase.gsub("\,","").tr(" ","_")}_#{@alignment_report.title.squish.downcase.gsub("\,","").tr(" ","_")}_#{I18n.l Time.zone.now, format: :for_report_CSV}"
    send_data csv, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{file_name}.csv"
  end

  def create
    create! do |success, failure|
      success.html do
        log_file_path = "#{Rails.root}/log/parser/#{Rails.env}/#{resource.id}.log"
        if resource.alignment_report_template.present? && File.exist?(log_file_path)
          @log_content = File.read(log_file_path)
          return render :log
        else
          return redirect_to admin_alignment_report_path(resource)
        end
      end
    end
  end

  def tool
    if resource.file_content_path.present? || resource.last_job_id.present?
      render :tool
    else
      flash[:error] = 'Please choose or upload file'
      redirect_to edit_file_admin_alignment_report_path(resource)
    end
  end

  def submit
    notice = resource.submit ? 'Alignment Report was successfully submitted' : "Can't submit Alignment Report"
    redirect_to edit_admin_product_alignment_report_path(resource), notice: notice
  end

  def update
    prms_hsh = params

    params[:alignment_report].each do |k,v|
      clean_text = remove_nbsp(params[:alignment_report][k])
      params[:alignment_report][k] = clean_text
    end

    alignment_report = AlignmentReport.where(id: params[:id]).first
    alignment_report.update_attributes(params[:alignment_report])
    if alignment_report.save
      respond_to do |format|
        format.json { render :json => alignment_report.attributes }
        format.html do
          notice = "Alignment Report was successfully updated"
          redirect_to admin_alignment_report_path, notice: notice
        end
      end
    else
      head status: 409
    end
  end

  def recalculate
    # select alignment report
    alignment_report = AlignmentReport.where(id: params[:id]).first
    # calculate new coverage percent
    coverage = Domain::AlignmentReport::Commands::CalculateCoveragePercent.! alignment_report
    alignment_report.set(:coverage_percent, coverage.round)
    alignment_report.set(:coverage_with_percent, "#{coverage.round}%")

    # return new coverage percent
    respond_to do |format|
      format.js { render :json => coverage.round}
    end
  end

  def update_file
    alignment_report_update_file
  end

  def destroy
    alignment_report = AlignmentReport.find(params[:id])

    if alignment_report.delete
      product = ::Domain::Product::Queries::Product.! alignment_report.product_id

      if product.workflow_ids.count > 1
        ProductWorkflowReportDeleteByAlignmentReportWorker.perform_async(alignment_report.id, product.id)
      else
        ProductWorkflowReportUpdateWorker.perform_async(product.id)
      end
    end

    redirect_to :back
  end

  def finalize
    notice = resource.finalize ? 'Alignment report is ready for preview' : "Can't submit Alignment report"
    redirect_to admin_product_path(resource.product), notice: notice
  end

  def switch_lock_state
    resource.switch_lock_state!
    redirect_to :back
  end

  protected

  add_breadcrumb 'Alignment Reports', :admin_alignment_reports_path

  def load_product
    build_resource.product = Product.where(id: params[:product_id]).first
    redirect_to admin_root_path if resource.product.nil?
  end

  def can_create_resource?
    if resource.product.preview_period?
      redirect_to [:admin, resource.product], alert: "You can't create Alignment Report for product with status \"#{resource.product.human_state_name}\"."
    end
  end

  def can_destroy_resource?
    unless resource.can_admin_destroy? || permit_destroy
      redirect_to [:admin, resource], alert: "You can't destroy this Alignment Report because it has already been started."
    end
  end

  def readable_fields
    @readable_fields ||= resource.readable_fields_for(:admin)
  end

  def writable_fields
    @writable_fields ||= resource.writable_fields_for(:admin) + [:first_sme, :second_sme, :third_sme]
  end

  def file_name
    "#{resource.alignment_template.grade} #{resource.product.title} #{Time.new.strftime '%m-%d-%Y'}"
  end

  def api_urls
    @standards_data_url = api_v1_admin_alignment_report_path(resource, format: :json)
    @standards_text_url = file_content_api_v1_admin_alignment_report_path(resource)
    @close_url = admin_alignment_report_path(resource)
  end

  def layout_by_action
    alignment_report_layout_by_action('admin')
  end

  def check_component_file
    redirect_to tool_admin_alignment_report_path(resource) if resource.component_has_pdf?
  end

  def permit_destroy
    params[:h].present?
  end
  helper_method :permit_destroy
end

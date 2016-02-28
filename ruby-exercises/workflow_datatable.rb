class AdminProductWorkflowDatatable
  delegate :params, to: :@view

  def initialize(view, status)
    @view = view
    @status = params["status"]
    @workflow = ::Domain::Product::Reports::Workflow::Index.new
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: count,
      iTotalDisplayRecords: records.total,
      aaData: data
    }
  end

private

  def data

    records.map do |record|

      [
        record.product_title,
        record.publisher_name,
        record.product_submitted_at,
        record.product_subject,
        record.product_grade,
        record.product_material_format,
        record.product_standard,
        record.product_state_adopted,
        record.publisher_alignment_percentage,
        record.ll_alignment_percentage,

        record.first_sme_name,
        record.first_sme_assigned_at,
        record.first_sme_submitted_at,

        record.second_sme_name,
        record.second_sme_assigned_at,
        record.second_sme_submitted_at,

        record.third_sme_name,
        record.third_sme_assigned_at,
        record.third_sme_submitted_at,

        record.editorial_reviewer_name,
        record.editorial_reviewer_assigned_at,
        record.editorial_reviewer_submitted_at,

        record.publisher_preview_started_at,
        record.publisher_preview_finished_at,
        record.published_at,
        record.product_status
      ]
    end
  end


  def records
    @records ||= fetch_records
  end

  def fetch_records
    filter = status_filter

    q = if params[:search][:value] && !params[:search][:value].empty?
      { match: { '_all' => params[:search][:value].downcase} }
    else
      { match_all: {} }
    end

    query = if filter
      { filtered: { query: q, filter: filter } }
    else
      q
    end

    records = @workflow.search(
      query: query,
      from: params[:start].to_i,
      size: per_page,
      sort: { "#{sort_column}" => {order: "#{sort_direction}"} })

    records
  end

  def count
    filter = status_filter
    total_count = @workflow.count( query: { filtered: { query: { match_all: {} }, filter: filter } })
    total_count
  end

  def status_filter
    case @status
    when 'submitted'
      filter = { and: [{ term: { product_status_sort: "submitted" } }, { missing: { field: "alignment_report_status" }  }] }
    when 'product_review'
      filter = { term: { product_status_sort: "submitted" } }
    when 'assigned_to_first_sme'
      filter = { term: { alignment_report_status_sort: "assigned_to_first_sme" } }
    when 'assigned_to_second_sme'
      filter = {term: { alignment_report_status_sort: "assigned_to_second_sme" }}
    when 'ready_for_preview_period'
      filter = {term: { product_status_sort: "ready_for_preview_period" }}
    when 'preview_period_started'
      filter = {term: { product_status_sort: "preview_period_started" }}
    when 'preview_period_has_paused'
      filter = {term: { product_status_sort: "preview_period_has_paused" }}
    when 'preview_period_finished'
      filter = {term: { product_status_sort: "preview_period_finished" }}
    when 'published'
      filter = {term: { product_status_sort: "live_on_ll_com" }}
    when 'all'
      filter = {}
    end
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w[product_title_sort publisher_name_sort product_submitted_at_sort product_subject_sort product_grade_sort product_material_format_sort product_standard_sort product_state_adopted publisher_alignment_percentage ll_alignment_percentage first_sme_name_sort first_sme_assigned_at_sort first_sme_submitted_at_sort second_sme_name_sort second_sme_assigned_at_sort second_sme_submitted_at_sort third_sme_name_sort third_sme_assigned_at_sort third_sme_submitted_at_sort editorial_reviewer_name_sort editorial_reviewer_assigned_at_sort editorial_reviewer_submitted_at_sort publisher_preview_started_at_sort publisher_preview_finished_at_sort published_at_sort product_status_sort]
    columns[params[:order]["0"][:column].to_i]
  end

  def sort_direction
    params[:order]["0"][:dir] == "desc" ? "desc" : "asc"
  end

end
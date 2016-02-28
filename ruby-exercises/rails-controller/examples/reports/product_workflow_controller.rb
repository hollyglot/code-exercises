class Admin::Reports::ProductWorkflowController < Admin::BaseController

  select_section :workflow_reports

  def index
    @status = params[:status]
    @heading = ::Domain::Product::Reports::Workflow::Heading.! @status

    respond_to do |format|
      format.html
      format.json { render json: AdminProductWorkflowDatatable.new(view_context, status) }
    end
  end

  def csv
    columns = %w[product_title_sort publisher_name_sort product_submitted_at_sort product_subject_sort product_grade_sort product_material_format_sort product_standard_sort state_adopted_sort publisher_alignment_percentage_sort ll_alignment_percentage_sort first_sme_name_sort first_sme_assigned_at_sort first_sme_submitted_at_sort second_sme_name_sort second_sme_assigned_at_sort second_sme_submitted_at_sort third_sme_name_sort third_sme_assigned_at_sort third_sme_submitted_at_sort editorial_reviewer_name_sort editorial_reviewer_assigned_at_sort editorial_reviewer_submitted_at_sort publisher_preview_started_at_sort publisher_preview_finished_at_sort published_at_sort product_status_sort]
    sort_by = columns[params["order"]["0"]["column"].to_i]
    sort_direction = params["order"]["0"]["dir"]
    status = params["status"]
    heading = ::Domain::Product::Reports::Workflow::Heading.! status
    heading_sanitized = heading.downcase.to_snake_case
    csv = ::Domain::Product::Reports::Workflow::Records::CSVBuilder.! sort_by, sort_direction, status
    file_name = "product_workflow_report_#{heading_sanitized}_#{I18n.l Time.zone.now, format: :for_report_CSV}"
    send_data csv, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{file_name}.csv"
  end

end

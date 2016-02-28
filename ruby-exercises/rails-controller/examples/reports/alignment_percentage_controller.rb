class Admin::Reports::AlignmentPercentageController < Admin::BaseController

  select_section :alignment_percentage_reports

  def index
    @status = params[:status]
    @table = ::Domain::Product::Reports::AlignmentPercentage::ByStatus::TableBuilder.! @status
    @heading = ::Domain::Product::Reports::AlignmentPercentage::ByStatus::Heading.! @status
  end

  def csv
    @status = params[:status]
    csv = ::Domain::Product::Reports::AlignmentPercentage::ByStatus::CSVBuilder.! @status
    file_name = "#{@status}_alignment_percentage_#{I18n.l Time.zone.now, format: :for_report_CSV}"
    send_data csv, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{file_name}.csv"
  end

end
class Admin::ImportPublishersController < Admin::BaseController
  select_section [:publishers, :batch]

  def new
  end

  def create
    new_publishers_count = 0
    emails = params[:publisher_emails].lines.map(&:chomp)
    output = ImportPublishersService.perform!(emails) if emails.present?

    if output.present?
      if output[:valid_emails].present?
        valid_emails = output[:valid_emails].join('<br/>')
        flash[:success] = "#{pluralize_without_number(output[:valid_emails].count, 'This', 'These')} #{pluralize_without_number(output[:valid_emails].count, 'publisher')} were added to the database:<br/>#{valid_emails}"
      end
      if output[:invalid_emails].present?
        invalid_emails = output[:invalid_emails].join('<br/>')
        flash[:error]   =  "We couldn't add #{pluralize_without_number(output[:invalid_emails].count, 'this', 'these')} #{pluralize_without_number(output[:invalid_emails].count, 'publisher')} to the database:<br/>#{invalid_emails}"
      end
    else
      flash[:notice] = 'No publishers were added'
    end

    if params[:open_rfp_page].present? && output.present? && output[:new_publisher_ids].present?
      redirect_to new_admin_rfp_path(check: output[:new_publisher_ids].join(','))
    else
      redirect_to admin_import_publishers_path
    end
  end

  def page_header
    'Add multiple publishers'
  end

  private

  add_breadcrumb 'Publishers', :admin_publishers_path
  add_breadcrumb 'Add multiple publishers', '', only: [:new]

end

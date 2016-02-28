class Admin::RfpsController < Admin::BaseController
  select_section :rfps

  def new
    @checked_publishers = params[:check].split(',') if params[:check]
  end

  def create
    @rfp = Rfp.new params[:rfp]
    if @rfp.save
      RfpSender.dispatch(@rfp.publishers)

      @rfp.publishers.each { |publisher| Activity.track_sent_rfp(current_admin, publisher) }
      @rfp.publishers.each { |publisher| publisher.set(:rfp_sent_date, Time.now.strftime("%Y/%m/%d")) }

      flash[:success] = 'RFP emails were successfully sent!'
      redirect_to admin_publishers_path
    else
      render :new
    end
  end


  def publishers_without_rfp
    Publisher.without_rfp
  end
  helper_method :publishers_without_rfp


  def publishers_with_rfp
    Publisher.with_rfp
  end
  helper_method :publishers_with_rfp


  def resource
    @rfp ||= Rfp.new
  end
  helper_method :resource


  def page_header
    'Send RFP Emails'
  end

  private

  add_breadcrumb 'Send RFP Emails', '', only: [:new]

end

class Admin::CustomEmailsController < Admin::BaseController
  inherit_resources
  select_section :custom_emails

  def show
    add_breadcrumb resource.subject, '#'
  end

  def edit
    add_breadcrumb resource.subject, '#'
  end

  def send_emails
    if resource.send_email
      flash[:notice] = 'E-mail was successfully sent'
    else
      flash[:alert] = 'Server error'
    end

    redirect_to :back
  end

  def send_test_email
    resource.test_emails = params[:custom_email][:test_emails]
    resource.send_test_email
  end

  def publishers_all
    @publishers_all ||= Publisher.all
  end
  helper_method :publishers_all

  def sme_all
    @sme_all ||= SME.all
  end
  helper_method :sme_all

  def er_all
    @er_all ||= EditorialReviewer.all
  end
  helper_method :er_all

  def customers_all
    @customers_all ||= Customer.all.uniq { |c| c.email }
  end
  helper_method :customers_all


  def publishers_without_products
    @publishers_without_products ||= Publisher.without_products
  end
  helper_method :publishers_without_products

  protected

  add_breadcrumb 'Custom Emails', :admin_custom_emails_path

  def collection
    end_of_association_chain.desc('created_at')
  end
end
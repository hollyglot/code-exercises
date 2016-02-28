class Admin::MailTemplatesController < Admin::BaseController
  inherit_resources

  select_section :mail_templates

  def new
    build_resource
    resource.from = Setting.app_config.info_email
    new!
  end

  def show
    add_breadcrumb resource.subject, '#'

    respond_to do |format|
      format.json { render json: resource }
      format.html { render :show }
    end
  end

  def edit
    add_breadcrumb resource.subject, '#'
  end


  protected

  add_breadcrumb 'Mail Templates', :admin_mail_templates_path
end

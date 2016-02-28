class Admin::SettingsController < Admin::BaseController

  def update
    if resource.update_attributes(params[:setting])
      flash[:success] = 'Settings were updated successfully'
      redirect_to edit_admin_setting_path
    else
      flash[:error] = 'Please check errors'
      render :edit
    end
  end

  def resource
    @setting ||= Setting.app_config
  end
  helper_method :resource


  def page_header
    'Edit Settings'
  end
end

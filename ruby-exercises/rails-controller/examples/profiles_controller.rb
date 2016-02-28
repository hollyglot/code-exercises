class Admin::ProfilesController < Admin::BaseController

  def edit
  end

  def update
    if params[:admin][:password].present?
      result = current_admin.update_attributes(params[:admin])
    else
      result = current_admin.update_without_password(params[:admin])
    end

    if result
      flash[:success] = 'Your profile was updated successfully!'
      redirect_to admin_root_path
    else
      render :edit
    end
  end

  def page_header
    'Edit My Account'
  end

end

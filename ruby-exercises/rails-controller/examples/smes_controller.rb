class Admin::SmesController < Admin::BaseController
  inherit_resources
  select_section [:sme, :list], except: :new
  select_section [:sme, :new], only: :new

  before_filter :clear_password_if_blank, only: [:create, :update]

  def create
    create! { collection_path }
  end

  def show
    add_breadcrumb resource.name, '#'
  end

  def edit
    add_breadcrumb resource.name, '#'
  end

  def update
    return redirect_to :back unless params[:sme].present?
    if params[:sme][:password].present?
      result = resource.update_attributes(params[:sme])
    else
      result = resource.update_without_password(params[:sme])
    end

    if result
      flash[:success] = 'Subject Matter Expert updated successfully'
      redirect_to collection_path
    else
      render :edit
    end
  end

  protected

  add_breadcrumb 'Subject Matter Experts', :admin_smes_path
  add_breadcrumb 'New', '', only: [:new]

  def page_header
    'Subject Matter Expert'
  end

  def resource_name
    'sme'
  end

  def clear_password_if_blank
    if params[:sme].present? && params[:sme][:password].blank?
      params[:sme][:password] = nil
    end
  end
end

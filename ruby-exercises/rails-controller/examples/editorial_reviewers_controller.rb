class Admin::EditorialReviewersController < Admin::BaseController
  inherit_resources
  select_section [:editorial_reviewers, :list], except: :new
  select_section [:editorial_reviewers, :new], only: :new

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
    return redirect_to :back unless params[:editorial_reviewer].present?
    if params[:editorial_reviewer][:password].present?
      result = resource.update_attributes(params[:editorial_reviewer])
    else
      result = resource.update_without_password(params[:editorial_reviewer])
    end

    if result
      flash[:success] = 'Editorial reviewer updated successfully'
      redirect_to collection_path
    else
      render :edit
    end
  end

  protected

  add_breadcrumb 'Editorial Reviewers', :admin_editorial_reviewers_path
  add_breadcrumb 'New', '', only: [:new]

  def clear_password_if_blank
    if params[:editorial_reviewer].present? && params[:editorial_reviewer][:password].blank?
      params[:editorial_reviewer][:password] = nil
    end
  end
end
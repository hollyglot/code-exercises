class Admin::DashboardController < Admin::BaseController

  select_section :dashboard

  def index
    @activities = Activity.recent.feed.page(params[:page]).per(50)
  end
end

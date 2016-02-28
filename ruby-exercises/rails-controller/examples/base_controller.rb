class Admin::BaseController < ApplicationController

  before_filter :authenticate_admin!
  before_filter :set_initial_breadcrumbs
  layout 'admin'


  private

  def set_initial_breadcrumbs
    add_breadcrumb 'Home', :root_path
  end
end

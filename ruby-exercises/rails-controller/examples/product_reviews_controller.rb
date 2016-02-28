class Admin::ProductReviewsController < Admin::BaseController
  inherit_resources
  actions :show, :edit, :update

  def edit
    resource.prepare_scenes!
  end

  def update
    update! do |success, failure|
      if params[:commit] == 'Submit to the Director of Editorial Reviews'
        unless resource.submit_for_director
          return render :update
        end
      end
      success.html { redirect_to [:admin, resource.product] }
      success.js
    end
  end
end
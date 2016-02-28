class Subscriber::ProductsController < Subscriber::BaseController
  inherit_resources

  skip_before_filter :reset_search_results, only: [:show, :compare]

  def show
    add_breadcrumb resource.title, :subscriber_product_path

    # get array of fill in the gaps that fill in 100% coverage
    fitgs = resource.sorted_fitg

    respond_to do |format|
      format.js { render :json => resource }
      format.html do
        product_view_data = {
          :collection => "product_views",
          :product_id => resource.id, 
          :subscriber_id => current_subscriber.id, 
          :referrer => request.referer,
          :timestamp => Time.now
        }
        puts product_view_data
        TrackViewsWorker.perform_async(product_view_data)

        fitgs.each do |fitg|
          fitg_view_data = {
            :collection => 'fill_in_the_gap_views',
            :product_id => resource.id, 
            :fitg_product_id => fitg.compared_product_id,
            :subscriber_id => current_subscriber.id,
            :referrer => 'product',
            :timestamp => Time.now
          }
          TrackFITGEventWorker.perform_async(fitg_view_data)
        end
      end
    end
  end

  def compare
    @ids = params[:products]
    if @ids && !@ids.empty?
      products = Product.find(@ids)
      @product1 = products[0]

      comparison_data = {
        :product_id => @product1.id,
        :comparison_product_ids => @ids,
        :subscriber_id => current_subscriber.id,
        :referrer => request.referer,
        :collection => 'product_info_comparison_views',
        :timestamp => Time.now
      }
      TrackComparisonViewsWorker.perform_async(comparison_data)

      @product2 = products[1]

      if @product2
        comparison_data = {
          :product_id => @product2.id,
          :comparison_product_ids => @ids,
          :subscriber_id => current_subscriber.id,
          :referrer => request.referer,
          :collection => 'product_info_comparison_views',
          :timestamp => Time.now
        }
        TrackComparisonViewsWorker.perform_async(comparison_data)
      end

      @product3 = products[2]

      if @product3
        comparison_data = {
          :product_id => @product3.id,
          :comparison_product_ids => @ids,
          :subscriber_id => current_subscriber.id,
          :referrer => request.referer,
          :collection => 'product_info_comparison_views',
          :timestamp => Time.now
        }
        TrackComparisonViewsWorker.perform_async(comparison_data)
      end

      # check if products have device compatibility
      @display_compatibility = ::Domain::Product::Views::Compare::DisplayDeviceCompatibility.! products

      # check if products' alignment reports are all CCSS standards. CCSS is not state adopted.
      @hide_state_adopted = ::Domain::Product::Views::Compare::HideStateAdopted.! products
    end

    @main_product_id = params[:main_product_id]

    @grades = []
    @grades << @product1.first_component.grade if @product1
    @grades << @product2.first_component.grade if @product2
    @grades << @product3.first_component.grade if @product3
    @grades = @grades.uniq unless @grades.empty?

    @subjects = []
    @subjects << @product1.first_component.subject.title if @product1
    @subjects << @product2.first_component.subject.title if @product2
    @subjects << @product3.first_component.subject.title if @product3
    @subjects = @subjects.uniq unless @subjects.empty?

    @hidden_rows = ""
    if params[:hidden_rows]
      @hidden_rows = params[:hidden_rows]
    end

    if params[:user_price1] || params[:user_price2] || params[:user_price3]
      @user_prices = [params[:user_price1], params[:user_price2], params[:user_price3]]
    end

    if params[:user_comment1] || params[:user_comment2] || params[:user_comment3]
      @user_comments = [params[:user_comment1], params[:user_comment2], params[:user_comment3]]
    end

    if params[:user_criteria]
      @user_criteria = params[:user_criteria]
    end

    respond_to do |format|
      format.xlsx do
        @comparison = Domain::Product::Reports::Comparison::Builder.! products, @display_compatibility, @subjects, @grades, @user_prices, @user_comments
        xlsx_file_name comparison_file_name
      end

      format.pdf do
        render :pdf => comparison_file_name
      end

      format.html
    end
  end

  protected

  def comparison_file_name
    "Product_Comparison_#{Time.new.strftime '%m-%d-%Y'}"
  end

  private

  def end_of_association_chain
    Product.published
  end

  def selected_layout
    params[:layout].present? && %w(list grid).include?(params[:layout]) ? params[:layout] : 'list'
  end
  helper_method :selected_layout
end

class Admin::BreakoutsController < Admin::BaseController
  include ViewHelper
  include HtmlHelper

  def update_breakout
    if params[:breakout_id]
      params[:id] = params[:breakout_id]
    end

    prms_hsh = params

    params.each do |k,v|
      clean_text = remove_nbsp(params[k])
      params[k] = clean_text
    end

    breakout = Breakout.where(id: params[:id]).first
    breakout.update_attributes(params)

    if breakout.save
      @breakout = {}
      breakout = breakout.to_json
      prms_hsh.each do |k,v|
        @breakout[k] = v if breakout[k]
      end

      respond_to do |format|
        format.json { render :json =>  @breakout}
      end
    else
      head status: 409
    end
  end

  def get_breakout
    breakout = Breakout.where(id: params[:id]).first

    if !breakout.nil?
        respond_to do |format|
          format.js { render :json => breakout }
        end
    else
      head status: 409
    end
  end
end
class Subscriber::StaticPagesController < Subscriber::BaseController
  inherit_resources

  def terms
    parent = Page.where(sluggable_field: 'terms').first
    subscription_type = current_subscriber.type

    case subscription_type
    when 'individual_account'
      @terms = TermsOfService.where(current: true, subscription_type: 'Individual').first
    when 'publisher_account'
      @terms = TermsOfService.where(current: true, subscription_type: 'Publisher').first
    when 'organization_member'
      @terms = TermsOfService.where(current: true, subscription_type: 'District/Campus').first
    when 'organizational_account'
      @terms = TermsOfService.where(current: true, subscription_type: 'District/Campus').first
    end
    @sections = parent.children.asc(:position)
  end

  def how_do_i
    parent = Page.where(sluggable_field: 'how-do-i').first
    @sections = parent.children.asc(:position)

    @reviews = params[:reviews]
  end

  def support
  end

  protected

  def render_search?
    false
  end
end

require 'ob_port/client'

module MageHand
  
  protected
  
  def obsidian_portal_login_required
    @mage_client = MageHand::Client.new(session[:request_token], session[:access_token],
      request.url, params)
    store_tokens
    return true if logged_in?

    redirect_to @mage_client.request_token.authorize_url
    false
  end
  
  def logged_in?
    @mage_client.logged_in?
  end
  
  def obsidian_portal
    @mage_client.access_token
  end
  
  def store_tokens
    session[:request_token] = @mage_client.request_token
    session[:access_token] = @mage_client.access_token
  end
end
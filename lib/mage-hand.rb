require 'ob_port/client'
require 'ob_port/user'

module MageHand
  
  protected
  
  def obsidian_portal_login_required
    @mage_client = MageHand::Client.new(session[:request_token], session[:access_token_key], 
      session[:access_token_secret], request.url, params)
    store_tokens
    return true if logged_in?

    redirect_to @mage_client.request_token.authorize_url
    false
  end
  
  def logged_in?
    @mage_client.logged_in?
  end
  
  def obsidian_portal
    @mage_client
  end
  
  def store_tokens
    session[:request_token] = @mage_client.request_token
    session[:access_token_key] = @mage_client.access_token_key
    session[:access_token_secret] = @mage_client.access_token_secret
  end
end
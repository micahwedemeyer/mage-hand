require 'ob_port/client'

module ObPort
  
  protected
  
  def ob_port_login_required
    @ob_client = ObPort::Client.new(session[:request_token], session[:access_token], request.url, params)
    store_tokens
    return true if logged_in?

    redirect_to @ob_client.request_token.authorize_url
    false
  end
  
  def logged_in?
    @ob_client.logged_in?
  end
  
  def store_tokens
    session[:request_token] = @ob_client.request_token
    session[:access_token] = @ob_client.access_token
  end
end
module MageHand
  LOGIN_URL = 'https://www.obsidianportal.com/'
  API_URL = 'http://api.obsidianportal.com/v1/users/me.json'
  
  class Client
    cattr_accessor :key, :secret
    attr_accessor :consumer, :request_token, :access_token
    
    def self.configure(key, secret)
      self.key = key
      self.secret = secret
    end
    
    def initialize(request_token=nil, access_token=nil, callback=nil, params=nil)
      @consumer = OAuth::Consumer.new( Client.key,Client.secret, {
        :site=>"https://www.obsidianportal.com/"})
      if request_token
        @request_token = request_token
        @access_token = access_token || @request_token.get_access_token(
          :oauth_verifier => params[:oauth_verifier])
      else
        @request_token = @consumer.get_request_token(:oauth_callback => callback)
      end
    end
    
    def logged_in?
      !!@access_token
    end
  end
end
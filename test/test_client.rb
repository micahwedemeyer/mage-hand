require 'helper'

class TestClient < Test::Unit::TestCase
  context "The Obsidian Portal client" do
    should "configure correctly with a key and secret" do
      assert_nothing_raised {MageHand::Client.configure('asdfasdf','asdfasdfasdfasdfasdf')} 
    end
  end
  
  context "An instance of the client" do
    setup do
      response = Net::HTTPResponse.new("1.1", 200, "")
      Net::HTTPResponse.any_instance.stubs(:body).returns "{'hello' : 'world'}"
      OAuth::AccessToken.any_instance.stubs(:post).returns(response)
      
      MageHand::Client.configure('asdfasdf', 'asdfasdfasdfasdfasdf')  
    end
    should "be logged in if initialized with an access_key and access_secret" do
      @client = MageHand::Client.new(nil, 'asdf', 'asdfsdafasdfasdf')
      assert_not_nil @client
      assert @client.logged_in?
    end
  end
end

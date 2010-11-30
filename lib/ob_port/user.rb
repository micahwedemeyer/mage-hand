module MageHand
  class User < Base
    attr_accessor :username, :profile_url, :avatar_image_url,
      :created_at, :last_seen_at, :utc_offset, :locale, :is_ascendant

    alias :is_ascendant? :is_ascendant
    
    def campaigns
      @campaigns
    end
    
    def campaigns=(new_campaigns)
      @campaigns = []
      new_campaigns.each do |campaign|
        @campaigns << Campaign.new(campaign)
      end
    end
  end
end
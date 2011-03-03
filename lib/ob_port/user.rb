module MageHand
  class User < Base
    attr_accessor :username, :profile_url, :avatar_image_url,
      :created_at, :last_seen_at, :utc_offset, :locale, :is_ascendant
    inflate_if_nil :avatar_image_url, :created_at, :last_seen_at, :utc_offset,
      :locale, :is_ascendant

    alias :is_ascendant? :is_ascendant

    attr_array :campaigns
    inflate_if_nil :campaigns
    
    private

    def individual_url
      "/v1/users/#{self.id}.json"
    end
  end
end
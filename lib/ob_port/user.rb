module MageHand
  class User
    attr_accessor :id, :username, :profile_url, :avatar_image_url,
      :created_at, :last_seen_at, :utc_offset, :locale, :is_ascendant
    
    def initialize(attributes)
      attributes ||= {}
      attributes.each do |key, value|
        setter = "#{key}="
        self.send setter, value if self.respond_to?(setter)
      end
    end
  end
end
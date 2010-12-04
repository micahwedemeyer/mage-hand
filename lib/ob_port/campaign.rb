module MageHand
  class Campaign < Base
    # public methods
    attr_accessor :name, :campaign_url, :role, :visibility, :game_master_id, :slug
    
    # Private/Friends
    attr_accessor :banner_image_url, :play_status, :looking_for_players, :created_at, :updated_at
    
    # Player/GM Only
    attr_accessor :lat, :lng
    
    def looking_for_players?
      looking_for_players
    end
  end
end
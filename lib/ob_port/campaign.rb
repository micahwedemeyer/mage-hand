module MageHand
  class Campaign < Base
    ROLES = {'game_master' => 'Game Master', 'player' => 'Player'}
    
    # public mini-object methods
    attr_accessor :name, :campaign_url, :role, :visibility
    
    attr_accessor :game_master_id, :slug
    inflate_if_nil :game_master_id, :slug
    
    # Private/Friends
    attr_accessor :banner_image_url, :play_status, :looking_for_players, :created_at, :updated_at
    inflate_if_nil :banner_image_url, :play_status, :looking_for_players, :created_at, :updated_at
    
    # Player/GM Only
    attr_accessor :lat, :lng
    inflate_if_nil :lat, :lng
    
    attr_array :players, :class_name => 'User'
    inflate_if_nil :players
    
    def looking_for_players?
      looking_for_players
    end
    
    def role_as_title_string
      ROLES[self.role]
    end
    
    def wiki_pages
      @wiki_pages ||= MageHand::WikiPage.load_wiki_pages(self.id)
    end
    
     def posts
       @adventure_logs ||= wiki_pages.select{|page| page.is_post?}
     end
     
     private

     def individual_url
       "/v1/campaigns/#{self.id}.json"
     end
  end
end
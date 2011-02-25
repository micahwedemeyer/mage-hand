module MageHand
  class Campaign < Base
    ROLES = {'game_master' => 'Game Master', 'player' => 'Player'}
    
    # public methods
    attr_accessor :name, :campaign_url, :role, :visibility, :game_master_id, :slug
    
    # Private/Friends
    attr_accessor :banner_image_url, :play_status, :looking_for_players, :created_at, :updated_at
    
    # Player/GM Only
    attr_accessor :lat, :lng
    
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
  end
end
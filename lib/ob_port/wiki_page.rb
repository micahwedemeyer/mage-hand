module MageHand
  class WikiPage < Base
    ROLES = {'game_master' => 'Game Master', 'player' => 'Player'}
    
    # public methods
    attr_accessor :slug, :name, :wiki_page_url, :campaign, :created_at, :updated_at
    
    # Private/Friends
    attr_accessor :type, :is_game_master_only, :body, :body_html, :tags
    
    # TODO Move these to the posts subclass when we have it.
    attr_accessor :post_title, :post_taglines, :post_time
    
    # GM Only fields
    attr_accessor :game_master_info, :game_master_info_markup
    
    def self.load_wiki_pages(campaign_id)
      wiki_hashes = JSON.parse(
        MageHand::client.access_token.get("/v1/campaigns/#{campaign_id}/wikis.json?type=Post").body)
      wiki_hashes.map {|hash| WikiPage.new(hash)}
    end
    
    def is_post?
      type == 'Post'
    end
  end
end
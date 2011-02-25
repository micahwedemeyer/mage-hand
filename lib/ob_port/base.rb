module MageHand
  class Base
    attr_accessor :id
    
    def initialize(attributes)
      update_attributes!(attributes)
    end
     
    def update_attributes!(attributes)
      return unless attributes
      attributes.each do |key, value|
        setter = "#{key}="
        self.send setter, value if self.respond_to?(setter)
      end
    end
    
    def inflate
      puts "Inflating wiki page with id: #{self.id}"
      hash = JSON.parse( MageHand::client.access_token.get(individual_url).body)
      update_attributes!(hash)
    end
    
    def self.model_name
      @_model_name ||= ActiveModel::Name.new(self)
    end
    
    def self.inflate_if_nil(method_name)
      self.class_eval do
        alias_method "#{method_name.to_s}_original".to_sym, method_name
        define_method method_name do
          inflate if self.send("#{method_name.to_s}_original".to_sym).nil?
          self.send("#{method_name.to_s}_original".to_sym)
        end
      end
    end
  end
end
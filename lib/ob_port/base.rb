module MageHand
  class Base
    attr_accessor :id
    
    def initialize(attributes)
      attributes ||= {}
      attributes.each do |key, value|
        setter = "#{key}="
        self.send setter, value if self.respond_to?(setter)
      end
    end
    
    def self.model_name
      @_model_name ||= ActiveModel::Name.new(self)
    end
  end
end
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
    
    def self.attr_array(method_name, options={})
      self.class_eval do
        name = method_name.to_s
        class_name = options[:class_name] || name.singularize.classify
        code = <<-CODE
          def #{name}
            @#{name}
          end
          
          def #{name}=(new_#{name})
            @#{name} = []
            new_#{name}.each do |#{name.singularize}|
              @#{name} << #{class_name}.new(#{name.singularize})
            end
          end
        CODE
        puts code
        module_eval code
      end
    end
    
    def self.inflate_if_nil(*method_names)
      self.class_eval do
        method_names.each do |method_name|
          alias_method "#{method_name.to_s}_original".to_sym, method_name
          define_method method_name do
            inflate if self.send("#{method_name.to_s}_original".to_sym).nil?
            self.send("#{method_name.to_s}_original".to_sym)
          end
        end
      end
    end
  end
end
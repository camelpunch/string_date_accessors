require 'date'
module StringDateAccessors
  def self.format=(string)
    @format = string
  end

  def self.format
    @format
  end

  def self.included(klass)
    klass.extend(ClassMethods)
  end

  def self.formatted(input)
    Date.strptime(input, format)
  rescue ArgumentError
    input
  end

  def invalid_date_accessors
    string_date_accessors_set.reject {|attribute| send(attribute).is_a?(Date)}
  end

  def string_date_accessors_set
    @string_date_accessors_set ||= []
  end

  module ClassMethods
    def string_date_accessors(*attributes)
      attributes.each do |attribute|
        define_method "#{attribute}=" do |input|
          if input.respond_to?(:strftime) 
            super input 
          elsif input.nil? || input.empty?
            return super(nil) # don't mark as set
          else 
            super StringDateAccessors.formatted(input)
          end
          string_date_accessors_set << attribute
        end
      end
    end
  end
end

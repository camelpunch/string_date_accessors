require 'rubygems'
require 'date'
require 'active_support'
module StringDateAccessors
  def self.date_format=(string)
    @date_format = string
  end

  def self.date_format
    @date_format
  end

  def self.datetime_format=(string)
    @datetime_format = string
  end

  def self.datetime_format
    @datetime_format
  end

  def self.included(klass)
    klass.extend(ClassMethods)
  end

  def self.formatted(input)
    date = Date.strptime(input, date_format)
    zone = date.to_time.zone
    datetime_utc = DateTime.strptime("#{input} #{zone}", "#{datetime_format} %Z").to_time.utc
    Time.utc(datetime_utc.year, 
             datetime_utc.month, 
             datetime_utc.day, 
             datetime_utc.hour,
             datetime_utc.min,
             datetime_utc.sec)
  rescue ArgumentError, NoMethodError => e
    date ? date : input
  end

  def invalid_date_accessors
    string_date_accessors_set.reject {|attribute| send(attribute).respond_to?(:strftime)}
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

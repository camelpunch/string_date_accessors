require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class ModelBase
  attr_accessor :punched_on, :patched_up_on
end

class StringDateInheritor < ModelBase
  include StringDateAccessors
  string_date_accessors :punched_on, :patched_up_on
end

describe StringDateAccessors do
  before do
    StringDateAccessors.format = '%Y/%m/%d'
    @object = StringDateInheritor.new
  end

  describe "invalid_date_accessors" do
    before do
      @object.punched_on = 'bad'
      @object.patched_up_on = '2009/12/25'
    end

    it "should return the symbols associated with non-dates" do
      @object.invalid_date_accessors.should include(:punched_on)
    end

    it "should not return the symbols associated with dates" do
      @object.invalid_date_accessors.should_not include(:patched_up_on)
    end
  end

  describe "date accessor" do
    it "should accept strings with slashes" do
      @object.punched_on = '2011/12/11'
      @object.punched_on.day.should == 11
      @object.punched_on.month.should == 12
      @object.punched_on.year.should == 2011
    end

    it "should accept Date objects" do
      @object.punched_on = Date.new(2011, 12, 11)
      @object.punched_on.day.should == 11
      @object.punched_on.month.should == 12
      @object.punched_on.year.should == 2011
    end

    it "should cope with blank strings" do
      @object.punched_on = ''
      @object.punched_on.should be_nil
    end
  end
end

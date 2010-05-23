require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class ModelBase
  attr_accessor :punched_on, :patched_up_on, :fell_at
end

class StringDateInheritor < ModelBase
  include StringDateAccessors
  string_date_accessors :punched_on, :patched_up_on, :fell_at
end

describe StringDateAccessors do
  before do
    StringDateAccessors.date_format = '%Y/%m/%d'
  end

  describe "formatted" do
    context "datetime" do
      it "should convert to UTC" do
        input = '21/05/10 10:30'
        StringDateAccessors.datetime_format = '%d/%m/%y %H:%M'
        Time.stub(:zone).and_return('(GMT+00:00) London')
        StringDateAccessors.formatted(input).zone.should == 'UTC'
      end
    end
  end

  describe "UK format" do
    before do
      StringDateAccessors.date_format = '%d/%m/%y'
      StringDateAccessors.datetime_format = '%d/%m/%y %H:%M'
    end

    context "entering time strings with slashes" do
      subject do
        inheritor = StringDateInheritor.new
        inheritor.punched_on = '11/12/09 15:03'
        inheritor.punched_on
      end

      its(:min) { should == 3 }
      its(:hour) { should == 15 }
      its(:day) { should == 11 }
      its(:month) { should == 12 }
      its(:year) { should == 2009 }
      it { should be_a(Time) }
    end

    context "entering date strings with slashes" do
      subject do
        inheritor = StringDateInheritor.new
        inheritor.punched_on = '11/12/09'
        inheritor.punched_on
      end

      its(:day) { should == 11 }
      its(:month) { should == 12 }
      its(:year) { should == 2009 }
      it { should be_a(Date) }
    end
  end

  describe "invalid dates" do
    subject do
      inheritor = StringDateInheritor.new
      inheritor.punched_on = 'bad'
      inheritor.patched_up_on = '2009/12/25'
      inheritor.fell_at = '25/05/10 15:00'
      inheritor
    end

    its(:invalid_date_accessors) { should include(:punched_on) }
    its(:invalid_date_accessors) { should_not include(:patched_up_on) }
    its(:invalid_date_accessors) { should_not include(:fell_at) }
  end

  describe "date accessor" do
    context "entering strings with slashes" do
      subject do
        inheritor = StringDateInheritor.new
        inheritor.punched_on = '2011/12/11'
        inheritor.punched_on
      end

      its(:day) { should == 11 }
      its(:month) { should == 12 }
      its(:year) { should == 2011 }
      it { should be_a(Date) }
    end

    context "entering Date objects" do
      subject do
        inheritor = StringDateInheritor.new
        inheritor.punched_on = Date.new(2011, 12, 11)
        inheritor.punched_on
      end

      its(:day) { should == 11 }
      its(:month) { should == 12 }
      its(:year) { should == 2011 }
    end

    context "entering DateTime objects" do
      subject do
        inheritor = StringDateInheritor.new
        inheritor.punched_on = DateTime.new(2011, 12, 11, 15, 30)
        inheritor.punched_on
      end

      its(:min) { should == 30 }
      its(:hour) { should == 15 }
      its(:day) { should == 11 }
      its(:month) { should == 12 }
      its(:year) { should == 2011 }
    end

    context "entering blank strings" do
      subject do
        inheritor = StringDateInheritor.new
        inheritor.punched_on = ''
        inheritor.punched_on
      end

      it { should be_nil }
    end

    context "entering nil" do
      subject do
        inheritor = StringDateInheritor.new
        inheritor.punched_on = nil
        inheritor.punched_on
      end

      it { should be_nil }
    end
  end
end

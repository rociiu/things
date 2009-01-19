require File.dirname(__FILE__) + '/../spec_helper'

describe Entry do
  
  before(:each) do
    @entry = Entry.create(:title => 'New To Do ')
  end
  
  it "should be valid" do
    @entry.should be_valid
  end
  
  it "should not be valid without title" do
    @entry.title = nil
    @entry.should_not be_valid
  end
  
end

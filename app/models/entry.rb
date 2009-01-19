class Entry < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :title#, :user
  named_scope :inbox, :conditions => { :status => "inbox" }
  named_scope :scheduled, :conditions => { :status => "scheduled" }
  named_scope :someday, :conditions => { :status => "someday" }
  
  def self.today
    find(:all).select { |e| e.status == "today" && e.due_at.today? }
  end
  
  def self.next
    find(:all).select { |e| e.status == "next" || (e.status == "today" && !e.due_at.today?) }
  end
  
  #def self.scheduled
  #  find(:all).select { |e| e.status == "scheduled" }
  #end
  #
  #def self.someday
  #  find(:all).select { |e| e.status == "someday" }
  #end
  #
  #def self.inbox
  #  find(:all).select { |e| e.status == "inbox" }
  #end
end

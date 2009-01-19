class AddScheduledAtToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :scheduled_at, :datetime
  end

  def self.down
    remove_column :entries, :scheduled_at
  end
end

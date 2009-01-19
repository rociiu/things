class AddStatusAndFinishedAtToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :status, :string
    add_column :entries, :finished_at, :datetime
  end

  def self.down
    remove_column :entries, :finished_at
    remove_column :entries, :status
  end
end

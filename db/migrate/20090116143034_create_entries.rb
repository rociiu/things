class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :title
      t.text :note
      t.datetime :due_at
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end

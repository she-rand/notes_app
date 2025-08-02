class AddIndexesToNotes < ActiveRecord::Migration[8.0]
  def change
    add_index :notes, :title
    add_index :notes, :created_at
  end
end

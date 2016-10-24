class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.text :text
      t.boolean :completed

      t.timestamps
    end
  end
end

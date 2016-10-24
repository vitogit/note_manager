class AddNoteRefToNote < ActiveRecord::Migration[5.0]
  def change
    add_reference :notes, :parent, foreign_key: true
  end
end

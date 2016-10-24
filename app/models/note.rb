class Note < ApplicationRecord
  acts_as_tree
  acts_as_taggable
  
  validates :text, presence: true 
  
  def toggle_complete
    self.completed = !completed
  end
end

class Note < ApplicationRecord
  acts_as_tree
  validates :text, presence: true 
  
  def toggle_complete
    self.completed = !completed
  end
end

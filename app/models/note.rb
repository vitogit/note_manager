class Note < ApplicationRecord
  acts_as_tree
  acts_as_taggable
  
  validates :text, presence: true 
  
  def toggle_complete
    self.completed = !completed
  end
  
  #tags can be a single string tag, or an array
  def self.search_by_tag (tags)
    Note.tagged_with(tags)
  end
end

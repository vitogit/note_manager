class Note < ApplicationRecord
  acts_as_tree
  acts_as_taggable
  before_save :parse_add_tags
  validates :text, presence: true

  def toggle_complete
    self.completed = !completed
  end

  #tags can be a single string tag, or an array
  def self.search_by_tag (tags)
    Note.tagged_with(tags)
  end

  private
  def parse_add_tags
    self.text.scan(/\B#\w+/).each do |tag|
        self.tag_list.add tag
    end
  end

end

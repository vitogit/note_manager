require 'rails_helper'

RSpec.describe Note, type: :model do
  it "is valid with valid attributes" do
    expect(Note.new(text: 'hello')).to be_valid
  end
  
  it "is not valid without text" do
    note = Note.new(text: nil)
    expect(note).to_not be_valid
  end 
  
  it "is a tree" do
    root      = Note.create(text: "root")
    child1    = root.children.create(text: "child1")
    child2    = root.children.create(text: "child2")
    expect(root.children.size).to equal 2
    expect(child1.parent).to equal(root)
  end
  
  it "toggle the complete attribute" do
    note = Note.create(text: "root")
    note.toggle_complete
    expect(note.completed).to equal(true)
    note.toggle_complete
    expect(note.completed).to equal(false)
  end  
  
  it "has tags" do
    note = Note.create(text: "root")
    note.tag_list.add("tag1") 
    expect(note.tag_list.size).to equal(1)
  end    
end

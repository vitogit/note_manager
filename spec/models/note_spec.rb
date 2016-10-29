require 'rails_helper'

RSpec.describe Note, type: :model do
  it "is valid with valid attributes" do
    expect(Note.new(text: 'hello')).to be_valid
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

  it "change note parent" do
    root = Note.create(text: "root")
    child1 = root.children.create(text: "child1")
    child2 = root.children.create(text: "child2")
    child2.set_parent(child1.id)
    expect(child2.parent_id).to equal(child1.id)
  end

  context "search_by_tag" do
    it "filter notes by a single tag" do
      note1 = Note.create(text: "n1")
      note1.tag_list.add("tag1", "tag2")
      note2 = Note.create(text: "n2")
      note2.tag_list.add("tag1", "tag3")
      note1.save
      note2.save

      expect(Note.search_by_tag("tag1").size).to eq(2)
      expect(Note.search_by_tag("tag3").size).to eq(1)
      expect(Note.search_by_tag("tag4").size).to eq(0)
    end

    it "filter notes by an array of tags" do
      note1 = Note.create(text: "n1")
      note1.tag_list.add("tag1", "tag2")
      note2 = Note.create(text: "n2")
      note2.tag_list.add("tag1", "tag3")
      note1.save
      note2.save

      expect(Note.search_by_tag(["tag1"]).size).to equal(2)
      expect(Note.search_by_tag(["tag1", "tag2"]).size).to equal(1)
      expect(Note.search_by_tag(["tag3", "tag4"]).size).to equal(0)
    end
  end

  context "add tags by regex" do
    it "add tags with alphanumeric and underline chars" do
      text = " hello #tag_1 #tag_2"
      note1 = Note.create(text: text)

      expect(Note.search_by_tag("#tag_1").size).to eq(1)
      expect(Note.search_by_tag("#tag_2").size).to eq(1)
    end
  end
end

class NoteController < ApplicationController
   before_action :set_note, only: [:show, :edit, :update, :destroy, :change_to_sibling, :change_parent, :add_children,:add_sibling, :toggle_complete]

  def index
    init
  end

  def destroy
    @note.destroy
    respond_to do |format|
       format.js
    end
  end

  def add_children
    @parent_note = @note
    @child_note = @parent_note.children.create(text: "")
    respond_to do |format|
      format.js
    end
  end

  def add_sibling
    if @note.parent
      @parent_note = @note.parent
      @sibling_note = @parent_note.children.create(text: "")
    end
    respond_to do |format|
      format.js
    end
  end

  def change_parent
    @note.set_parent params[:parent_id] if is_integer? params[:parent_id]
  end

  def change_to_sibling
    grandpa = @note.parent().parent()
    @note.set_parent grandpa.id if grandpa
  end

  def toggle_complete
    @note.toggle_complete
    @note.save
    respond_to do |format|
      format.js
    end
  end

  def update
    if @note.update_attributes(note_params)
      # Handle a successful update.
    else
      flash[:danger] = @note.errors.full_messages
      render :root
    end
  end

  def reload_tag_list
    render :partial => "tag_list"
  end

  def reload_main_notes
    init
    render :partial => "note_partial", :locals => { note: @root  }
  end


   private

   def set_note
      @note = Note.find(params[:id])
   end

   def note_params
      params.require(:note).permit(:text, :completed)
   end

   def init
     @root = Note.first
     if @root.nil?
       @root=  Note.create(text:'root')
       @root.children.create(text:'')
     end
   end
   
  def is_integer? (number)
    number.to_i.to_s == number
  end   
end

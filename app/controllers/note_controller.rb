class NoteController < ApplicationController
   before_action :set_note, only: [:show, :edit, :update, :destroy, :add_children, :toggle_complete]
  
  def index
    @root = Note.first || Note.create(text:'root')
  end

  def destroy
    @note.destroy
    respond_to do |format|
       format.js
    end
  end
  
  def add_children
    @parent_note = @note
    @child_note = @parent_note.children.create(text: "child1")
    respond_to do |format|
      format.js 
    end
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
  
   private
   
   def set_note
      @note = Note.find(params[:id])
   end
   
   def note_params
      params.require(:note).permit(:text, :completed)
   end  
end

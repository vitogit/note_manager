class NoteController < ApplicationController
   before_action :set_note, only: [:show, :edit, :update, :destroy, :add_children, :toggle_complete]
  
  def index
    @root = Note.first || Note.create(text:'root')
  end

  # DELETE /notes/1.json
  def destroy
    @note.destroy
       respond_to do |format|
       format.json { head :no_content }
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
    respond_to do |format|
      format.js
    end
  end
  
   private
   
   def set_note
      @note = Note.find(params[:id])
   end
   
   def note_params
      params.require(:note).permit(:name, :completed)
   end  
end

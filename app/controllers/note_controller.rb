class NoteController < ApplicationController
   before_action :set_note, only: [:show, :edit, :update, :destroy, :add_children, :toggle_complete]
  
  def index
    @notes = Note.all
    @note_root = Note.new(text: 'root')
  end

  # # POST /notes
  # # POST /notes.json
  # def create
  #   @note = Note.new(note_params)
  #   respond_to do |format|
  #      if @note.save
  #         format.html { redirect_to @note, notice: 'Note was successfully created.' }
  #         format.json { render :show, status: :created, location: @note }
  #      else
  #         format.html { render :new }
  #         format.json { render json: @note.errors, status: :unprocessable_entity }
  #      end
  #   end
  # end
  # 
  # # PATCH/PUT /notes/1
  # # PATCH/PUT /notes/1.json
  # def update
  #   respond_to do |format|
  #      if @note.update(note_params)
  #         format.html { redirect_to @note, notice: 'Note was successfully updated.' }
  #         format.json { render :show, status: :ok, location: @note }
  #      else
  #         format.html { render :edit }
  #         format.json { render json: @note.errors, status: :unprocessable_entity }
  #      end
  #   end
  # end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
       respond_to do |format|
       format.html { redirect_to :root, notice: 'Note was successfully destroyed.' }
       format.json { head :no_content }
    end
  end
  
  def add_children
    respond_to do |format|
      format.js #add_question.js.erb
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

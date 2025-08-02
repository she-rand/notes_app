class NotesController < ApplicationController
   # execute set_note before of show, edit, update, destroy
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  def index
    @notes = Note.all
    # If there is search parameter filter
    @notes = @notes.search(params[:search]) if params[:search].present?
    # sort for most recent
    @notes = @notes.order(created_at: :desc).limit(50)
  end

  def show
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    
    if @note.save
      # If succesfully saved, redirect
      redirect_to @note, notice: 'Note was successfully created.'
    else
      # If errors, show the form
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to @note, notice: 'Note was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
     @note.destroy
    redirect_to notes_url, notice: 'Note was successfully deleted.'
  end
   #search de note by id
  def set_note
    @note = Note.find(params[:id])
  end
  
  # allow safe parameters
  def note_params
    params.require(:note).permit(:title, :content)
  end
end

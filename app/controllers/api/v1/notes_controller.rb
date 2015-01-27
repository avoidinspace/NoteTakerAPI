class Api::V1::NotesController < ApplicationController
  before_action :set_note, only: [:show, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all

    render json: {notes: @notes}
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    render json: {note: @note}
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)

    if @note.save
      render json: {note: @note}, status: :created, location: api_v1_note_url(@note)
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    @note = Note.find(params[:id])

    if @note.update(note_params)
      render json: {note: @note}, status: :accepted, location: api_v1_note_url(@note)
      head :no_content
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy

    head :no_content
  end

  private

    def set_note
      @note = Note.find(params[:id])
    end

    def note_params
      r = params[:note].nil? ? params : params.require(:note)
      r.permit(:title, :content)
    end
end

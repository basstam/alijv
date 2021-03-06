class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!, except: [:new, :create, :show, :confirmation]

  # GET /participants
  # GET /participants.json
  def index
    @participants = Participant.all
  end

  def confirmation
    @participant = Participant.where(:uuid => params[:id]).first
    redirect_to new_participant_path if @participant.nil?
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
  end

  # GET /participants/new
  def new
    @participant = Participant.new
  end


  # GET /participants/1/edit
  def edit
  end

  # POST /participants
  # POST /participants.json
  def create
    @participant = Participant.new(participant_params).add_participation
    respond_to do |format|
      if @participant
        if user_signed_in?
          format.html { redirect_to @participant, notice: t('activerecord.successful.messages.created', :model => @participant.class.model_name.human)  }
          format.json { render action: 'show', status: :created, location: @participant }
        else
          format.html { redirect_to confirmation_participant_path(@participant.uuid) }
          ParticipantMailer.confirmation(@participant).deliver
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participants/1
  # PATCH/PUT /participants/1.json
  def update
    respond_to do |format|
      if @participant.update(participant_params)
        format.html { redirect_to @participant, notice: t('activerecord.successful.messages.updated', :model => @participant.class.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant.destroy
    respond_to do |format|
      format.html { redirect_to participants_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participant_params
      params.require(:participant).permit(:firstname, :lastname, :street, :street_number, :zipcode, :city, :email, :phone, :date_of_birth, :gender, :distance, :activity_id)
    end
end

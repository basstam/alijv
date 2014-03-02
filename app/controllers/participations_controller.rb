class ParticipationsController < ApplicationController
  before_action :set_participation, only: [:show, :edit, :update, :destroy]

  # GET /participations
  # GET /participations.json
  def index
    @participations = Participation.all
  end

  # GET /participations/1
  # GET /participations/1.json
  def show
    # @participation = Participation.find(params[:id])
    # @participation.participants.build
    # @participation.categories.build
    # respond_to do |format|
    #   format.html # show.html.erb
    #   format.json { render json: @participation }
    # end  
  end

  # GET /participations/new
  def new
    @participation = Participation.new
  end

  # GET /participations/1/edit
  def edit
  end

  # POST /participations
  # POST /participations.json
  def create
    @participation = Participation.new(participation_params)

    respond_to do |format|
      if @participation.save
        format.html { redirect_to @participation, notice: t('activerecord.successful.messages.created', :model => @participation.class.model_name.human)  }
        format.json { render action: 'show', status: :created, location: @participation }
      else
        format.html { render action: 'new' }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participations/1
  # PATCH/PUT /participations/1.json
  def update
    respond_to do |format|
      if @participation.update(participation_params)
        format.html { redirect_to @participation, notice: t('activerecord.successful.messages.updated', :model => @participation.class.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participations/1
  # DELETE /participations/1.json
  def destroy
    @participation.destroy
    respond_to do |format|
      format.html { redirect_to participations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participation
      @participation = Participation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participation_params
      params.require(:participation).permit(:participant.firstname, :participant.lastname, :participant.street, :participant.street_number, :participant.zipcode, :participant.city, :participant.email, :participant.phone, :participant.date_of_birth, :participant.gender, :category.distance, :category.description)
    end
end

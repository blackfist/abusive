class IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  autocomplete :department, :name, full: true, extra_data: [:city, :state, :county, :level]

  # GET /incidents
  # GET /incidents.json
  def index
    if params[:search_query].present?
      @incidents = Incident.search(params[:search_query]).records
    else
      @incidents = Incident.all
    end

    respond_to do |format|
      format.html
      format.csv {send_data @incidents.to_csv}
    end
  end

  # GET /incidents/1
  # GET /incidents/1.json
  def show
  end

  # GET /incidents/new
  def new
    @incident_count = Incident.count
    @incident_form = IncidentForm.new
  end

  # GET /incidents/1/edit
  def edit
    @incident = Incident.find(params["id"])
  end

  # POST /incidents
  # POST /incidents.json
  def create
    @incident_form = IncidentForm.new(incident_params)

    respond_to do |format|
      if @incident_form.save
        format.html { redirect_to incidents_url, notice: 'Incident was successfully created.' }
        format.json { render :show, status: :created, location: @incident }
      else
        format.html { render :new }
        format.json { render json: @incident_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidents/1
  # PATCH/PUT /incidents/1.json
  def update
    respond_to do |format|
      if @incident.update(incident_params)
        format.html { redirect_to @incident, notice: 'Incident was successfully updated.' }
        format.json { render :show, status: :ok, location: @incident }
      else
        format.html { render :edit }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidents/1
  # DELETE /incidents/1.json
  def destroy
    @incident.destroy
    respond_to do |format|
      format.html { redirect_to incidents_url, notice: 'Incident was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incident
      @incident = Incident.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incident_params
      params.require(:incident).permit(:incident_summary, :incident_year, :incident_month,
          :reported_year, :reported_month, :notes,
          :location_state, :location_city, :location_county,
          :context, :location_notes, :victim_count, :abuse_force,
          :abuse_search, :abuse_misconduct, :abuse_intimidation,
          :abuse_sexual, :victim_animal, :abuse_restrained,:outcome_dollars,:abuse_notes,
          {victim_race_list: []}, :victim_notes, {references_attributes: [:id, :url, :headline, :org_name, :_destroy]},
          :department_name, :department_city, :department_state,
          :department_county, :department_level, :department_notes, :officer_count, :officer_multiple_incident,
          {officer_race_list: []}, {officer_year_list: []}, {officer_gender_list: []},
          {victim_age_list: []}, {victim_gender_list: []},
          {abuse_force_variety_list: []}, {abuse_search_variety_list: []},
          {abuse_misconduct_variety_list: []},{abuse_intimidation_variety_list: []},
          {abuse_sexual_variety_list: []}, {physical_outcome_variety_list: []},
          {legal_outcome_variety_list: []}, {hr_outcome_variety_list: []}, {internal_outcome_variety_list: []},
          {department_statement_variety_list: []}, {union_statement_variety_list: []} )
    end
end

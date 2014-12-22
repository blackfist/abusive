class ContributionsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :index]
  def new
    @contribution = Contribution.new
  end

  def create
    @contribution = Contribution.new(contribution_params)

    respond_to do |format|
      if @contribution.save
        format.html { redirect_to contributions_url, notice: 'Contribution was successfully created.' }
        format.json { render :show, status: :created, location: @contribution }
      else
        format.html { render :new }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @contributions = Contribution.all
  end

  private
    def contribution_params
      params.require(:contribution).permit(:contribution_summary,
        :contribution_start_year, :contribution_end_year,
        :contribution_start_month, :contribution_end_month,
        :contribution_location_city, :contribution_location_state )
    end

end

class ContributionsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :index]
  def new
    @contribution = Contribution.new
    @contribution.references.build
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
      params.require(:contribution).permit(:summary,
        :start_year, :end_year,
        :start_month, :end_month,
        :location_city, :location_state,
        :category )
    end

end

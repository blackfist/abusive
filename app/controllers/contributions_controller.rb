class ContributionsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :index, :show]
  autocomplete :department, :name, full: true, extra_data: [:city, :state, :county, :level]

  def new
    @contribution = Contribution.new
    @contribution.references.build
  end

  def create
    @contribution = Contribution.new(contribution_params)
    @d = Department.find_or_create_by!(name: params[:contribution_department_name],
                                      city: params[:contribution_department_city],
                                      state: params[:contribution_department_state],
                                      county: params[:contribution_department_county],
                                      level: params[:contribution_department_level])
    @contribution.department = @d

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
    if params[:search_query].present?
      @contributions = Contribution.search(params[:search_query]).records
    else
      @contributions = Contribution.all
    end
  end

  def show
    @contribution = Contribution.find(params[:id])
  end

  private
    def contribution_params
      params.require(:contribution).permit(:summary,
        :start_year, :end_year,
        :start_month, :end_month,
        :location_city, :location_state,
        :category, {references_attributes: [:id, :url, :headline, :org_name, :_destroy]} )
    end

end

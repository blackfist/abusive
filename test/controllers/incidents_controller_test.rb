require 'test_helper'

class IncidentsControllerTest < ActionController::TestCase
  setup do
    @incident = incidents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:incidents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create incident" do
    assert_difference('Incident.count') do
      post :create, incident: { incident_day: @incident.incident_day, incident_id: @incident.incident_id, incident_month: @incident.incident_month, incident_summary: @incident.incident_summary, incident_year: @incident.incident_year, notes: @incident.notes, reported_day: @incident.reported_day, reported_month: @incident.reported_month, reported_year: @incident.reported_year }
    end

    assert_redirected_to incident_path(assigns(:incident))
  end

  test "should show incident" do
    get :show, id: @incident
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @incident
    assert_response :success
  end

  test "should update incident" do
    patch :update, id: @incident, incident: { incident_day: @incident.incident_day, incident_id: @incident.incident_id, incident_month: @incident.incident_month, incident_summary: @incident.incident_summary, incident_year: @incident.incident_year, notes: @incident.notes, reported_day: @incident.reported_day, reported_month: @incident.reported_month, reported_year: @incident.reported_year }
    assert_redirected_to incident_path(assigns(:incident))
  end

  test "should destroy incident" do
    assert_difference('Incident.count', -1) do
      delete :destroy, id: @incident
    end

    assert_redirected_to incidents_path
  end
end

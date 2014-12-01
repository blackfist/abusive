json.array!(@incidents) do |incident|
  json.extract! incident, :id, :incident_id, :incident_summary, :incident_year, :incident_month, :incident_day, :reported_year, :reported_month, :reported_day, :notes
  json.url incident_url(incident, format: :json)
end

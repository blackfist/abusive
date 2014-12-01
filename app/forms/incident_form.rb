# https://www.reinteractive.net/posts/158-form-objects-in-rails
class IncidentForm
  include SimpleFormObject

  attribute :incident_summary, :text
  attribute :incident_year, :integer
  attribute :incident_month, :integer
  attribute :reported_year, :integer
  attribute :reported_month, :integer
  attribute :location_state, :string
  attribute :location_city, :string
  attribute :context, :text
  attribute :location_notes, :text
  attribute :abuse_force, :boolean
  attribute :abuse_search, :boolean
  attribute :abuse_misconduct, :boolean
  attribute :abuse_intimidation, :boolean
  attribute :abuse_sexual, :boolean
  attribute :abuse_force_variety_list
  attribute :abuse_search_variety_list
  attribute :abuse_misconduct_variety_list
  attribute :abuse_intimidation_variety_list
  attribute :abuse_sexual_variety_list
  attribute :victim_animal, :boolean
  attribute :abuse_restrained, :boolean
  attribute :abuse_notes, :text
  attribute :victim_count, :integer
  attribute :victim_race_list
  attribute :victim_age_list
  attribute :victim_gender_list
  attribute :victim_notes, :text
  attribute :physical_outcome_variety_list
  attribute :legal_outcome_variety_list
  attribute :hr_outcome_variety_list
  attribute :internal_outcome_variety_list
  attribute :department_statement_variety_list
  attribute :union_statement_variety_list
  attribute :outcome_dollars, :integer

  # Attributes for the reference article
  attribute :references_attributes

  # Attributes for the police department
  attribute :department_name, :string
  attribute :department_city, :string
  attribute :department_county, :string
  attribute :department_state, :string
  attribute :department_notes, :string
  attribute :department_level, :string

  # Attributes for the police officers
  attribute :officer_count, :integer
  attribute :officer_race_list
  attribute :officer_year_list
  attribute :officer_gender_list
  attribute :officer_multiple_incident, :boolean

  validates :incident_summary, presence: true
  validates :incident_year, presence: true
  validates :reported_year, presence: true
  validates :location_state, presence: true
  validates :context, presence: true
  #validates :reference_url, presence: true
  validates :department_name, presence: true
  validates :department_level, presence: true



  # Forms are never themselves persisted
  # This might not be necessary in Rails 4 since activemodel
  # defaults to false
  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  def persist!
    @department = Department.find_or_create_by!(name: department_name,
      city: department_city,
      state: department_state,
      county: department_county,
      level: department_level)
    @incident = @department.incidents.create!(incident_summary: incident_summary,
      incident_year: incident_year,
      incident_month: incident_month,
      reported_year: reported_year,
      reported_month: reported_month,
      location_state: location_state,
      location_city: location_city,
      context: context,
      location_notes: location_notes,
      abuse_force: abuse_force,
      abuse_search: abuse_search,
      abuse_misconduct: abuse_misconduct,
      abuse_intimidation: abuse_intimidation,
      abuse_sexual: abuse_sexual,
      abuse_force_variety_list: abuse_force_variety_list,
      abuse_search_variety_list: abuse_search_variety_list,
      abuse_misconduct_variety_list: abuse_misconduct_variety_list,
      abuse_intimidation_variety_list: abuse_intimidation_variety_list,
      abuse_sexual_variety_list: abuse_sexual_variety_list,
      victim_animal: victim_animal,
      abuse_restrained: abuse_restrained,
      abuse_notes: abuse_notes,
      victim_count: victim_count,
      victim_race_list: victim_race_list,
      victim_age_list: victim_age_list,
      victim_gender_list: victim_gender_list,
      victim_notes: victim_notes,
      victim_count: victim_count,
      physical_outcome_variety_list: physical_outcome_variety_list,
      legal_outcome_variety_list: legal_outcome_variety_list,
      hr_outcome_variety_list: hr_outcome_variety_list,
      internal_outcome_variety_list: internal_outcome_variety_list,
      department_statement_variety_list: department_statement_variety_list,
      union_statement_variety_list: union_statement_variety_list,
      officer_count: officer_count,
      officer_race_list: officer_race_list,
      officer_year_list: officer_year_list,
      officer_gender_list: officer_gender_list,
      officer_multiple_incident: officer_multiple_incident,
      outcome_dollars: outcome_dollars)
    references_attributes.each do |r|
      @incident.references.create(r[1])
    end
  end

end

# http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/
# http://pivotallabs.com/form-backing-objects-for-fun-and-profit/
# https://www.reinteractive.net/posts/158-form-objects-in-rails

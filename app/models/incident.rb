# == Schema Information
#
# Table name: incidents
#
#  id                        :integer          not null, primary key
#  uuid                      :string
#  incident_summary          :text
#  incident_year             :integer
#  incident_month            :integer
#  reported_year             :integer
#  reported_month            :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  location_state            :string
#  location_city             :string
#  location_county           :string
#  location_notes            :text
#  context                   :string
#  victim_count              :integer
#  victim_animal             :boolean
#  victim_notes              :text
#  abuse_force               :boolean
#  abuse_search              :boolean
#  abuse_misconduct          :boolean
#  abuse_intimidation        :boolean
#  abuse_sexual              :boolean
#  abuse_restrained          :boolean
#  abuse_notes               :text
#  outcome_dollars           :integer
#  department_id             :integer
#  officer_count             :integer
#  officer_multiple_incident :boolean
#

require 'securerandom'
require 'elasticsearch/model'
class Incident < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  CONTEXT_VALUES = [["911 Call","911"],
    ["Traffic Stop","traffic-stop"],
    ["Serving Search Warrant","search-warrant"],
    ["Protest","protest"],
    ["Border Crossing","border-crossing"],
    ["Checkpoint","checkpoint"],
    ["Recording Police","recording"],
    ["Chance Encounter","chance"],
    ["In Custody","custody"],
    ["Unknown","unknown"],
    ["Other","other"]]

  VIC_RACE_VALUES = [["White (European)", "white"],
    ['African-American','black'],
    ['Asian','asian'],
    ['Hispanic/Latino','latino'],
    ['Native American','native-american'],
    ['Other','other'],
    ['Unknown','unknown']]

  VIC_AGE_VALUES = [["Newborn to five years","0-5"],
    ["Six to 12","6-12"],
    ["13 to 17","13-17"],
    ["18 to 24","18-24"],
    ["25 to 34","25-34"],
    ["35 to 44","35-44"],
    ["45 to 54","45-54"],
    ["55 to 64","55-64"],
    ["65 and over","65+"],
    ["Unknown","unknown"]]

  VIC_GENDER_VALUES = [["Male","male"],
    ["Female","female"],
    ["Transgendered","transgendered"],
    ["Unknown","unknown"]]

  FORCE_VALUES = [["Firearm","firearm"],
    ["Taser","taser"],
    ["Chemical","chemical"],
    ["Impact Weapon","impact-weapon"],
    ["Hands/Feet","unarmed"],
    ["Destruction of Property","destruction-property"],
    ["Confiscation of Property","confiscation"],
    ["Use of Dog","dog"],
    ["Other","other"],
    ["Unknown","unknown"]]

  SEARCH_VALUES = [["Vehicle","vehicle"],
    ["Home","home"],
    ["Person","person"],
    ["Strip","strip"],
    ["Cavity","cavity"],
    ["Other","other"],
    ["Unknown","unknown"]]

  MISCONDUCT_VALUES = [["Testilying","testilying"],
    ["False report (not in court)","false-report"],
    ["Bribery (Make or accept)","bribe"],
    ["Falsifying /Tampering with Evidence","falsifying-evidence"],
    ["Misuse Data","misuse-data"],
    ["Theft","theft"],
    ["Civil Forfeiture","civil-forfeit"],
    ["False arrest","false-arrest"],
    ["False detainment (no arrest)","false-detainment"],
    ["Other","other"],
    ["Unknown","unknown"]]

  INTIMIDATION_VALUES = [["Show of force","show-of-force"],
    ["Threats","threats"],
    ["Verbal Abuse","verbal-abuse"],
    ["Harassing/Stalking","harass-stalk"],
    ["Other","other"],
    ["Unknown","unknown"]]

  SEXUAL_VALUES = [["Harassment","harassment"],
    ["Abuse of a minor","abuse-minor"],
    ["Abuse of adult","abuse-adult"],
    ["Other","other"],
    ["Unknown","unknown"]]

  PHYSICAL_OUTCOME_VALUES = [["Someone killed (including officer)","killed"],
    ["Someone injured (including officer)", "injured"],
    ["Unknown","unknown"]]

  LEGAL_OUTCOME_VALUES = [["External Investigation","external-investigation"],
    ["Lawsuit filed","lawsuit"],
    ["Fines/Awards","fines"],
    ["Settlement","settlement"],
    ["Criminal charges","criminal-charges"],
    ["Unrelated Convictions vacated/","vacated"],
    ["Unknown","unknown"]]

  HR_OUTCOME_VALUES = [["Paid Suspension","paid-suspension"],
    ["Unpaid Suspension","unpaid-suspension"],
    ["Demoted/Reassigned","demoted"],
    ["Fired","fired"],
    ["Quit/Resigned","quit"],
    ["Unknown","unknown"]]

  INTERNAL_OUTCOME_VALUES = [["Cleared","cleared"],
    ["Sanctioned","sanctioned"],
    ["Other","other"],
    ["Unknown","unknown"]]

  DEPARTMENT_UNION_STATEMENT_VALUES = [["Acted appropriately","acted-appropriately"],
    ["Acted inappropriately","acted-inappropriately"],
    ["Wait and see/benefit of doubt","wait"],
    ["Other","other"],
    ["Unknown","unknown"]]

  OFFICER_YEARS_VALUES = [["0 to 4","0-4"],
    ["5 to 9","5-9"],
    ["10 to 14","10-14"],
    ["15 to 19","15-19"],
    ["20 or more","20+"],
    ["Unknown","unknown"]]

  TAG_VARIABLES = [["VIC_RACE_VALUES","vic.race.","victim_race_list"],
    ["VIC_AGE_VALUES","vic.age.","victim_age_list"],
    ["VIC_GENDER_VALUES","vic.gender.","victim_gender_list"],
    ["FORCE_VALUES","abuse.force.","abuse_force_variety_list"],
    ["SEARCH_VALUES","abuse.search.","abuse_search_variety_list"],
    ["MISCONDUCT_VALUES","abuse.misconduct.","abuse_misconduct_variety_list"],
    ["INTIMIDATION_VALUES","abuse.intimidation.","abuse_intimidation_variety_list"],
    ["SEXUAL_VALUES","abuse.sexual.","abuse_sexual_variety_list"],
    ["PHYSICAL_OUTCOME_VALUES","outcome.physical.","physical_outcome_variety_list"],
    ["LEGAL_OUTCOME_VALUES","outcome.legal.","legal_outcome_variety_list"],
    ["HR_OUTCOME_VALUES","outcome.hr","hr_outcome_variety_list"],
    ["INTERNAL_OUTCOME_VALUES","outcome.internal.","internal_outcome_variety_list"],
    ["OFFICER_YEARS_VALUES","officer.years.","officer_year_list"]]

  acts_as_taggable_on :victim_race, :victim_age, :victim_gender,
    :abuse_force_variety, :abuse_search_variety, :abuse_misconduct_variety,
    :abuse_intimidation_variety, :abuse_sexual_variety, :physical_outcome_variety,
    :legal_outcome_variety, :hr_outcome_variety, :internal_outcome_variety,
    :department_statement_variety, :union_statement_variety, :officer_race,
    :officer_gender, :officer_year

  validates :incident_year, numericality: {greater_than_or_equal_to: 2000,
                                           less_than_or_equal_to: 2015},
                            presence: true
  validates :incident_month, numericality: {greater_than_or_equal_to: 1,
                                            less_than_or_equal_to: 12},
                             allow_blank: true
  validates :reported_year, numericality: {greater_than_or_equal_to: 2000,
                                           less_than_or_equal_to: 2015},
                            presence: true
  validates :reported_month, numericality: {greater_than_or_equal_to: 1,
                                            less_than_or_equal_to: 12},
                             allow_blank: true

  validates :incident_summary, presence: true
  validates :location_state, presence: true
  validates :context, presence: true, inclusion: {in: CONTEXT_VALUES.map{|r| r[1]}}

  after_initialize :make_uuid
  has_many :references, :inverse_of => :incident
  accepts_nested_attributes_for :references, allow_destroy: true
  belongs_to :department, :inverse_of => :incidents
  before_save :sanity_check


  def make_uuid
    self.uuid ||= SecureRandom.uuid
  end

  def self.to_csv
    # Start by defining our column names
    cols = column_names
    Incident::TAG_VARIABLES.each do |var|
      cols += eval("Incident::#{var[0]}").map{|v| "#{var[1]}#{v[1]}"}
    end
    cols += Incident::VIC_RACE_VALUES.map{|r| "officer.race.#{r[1]}"}
    cols += Incident::VIC_GENDER_VALUES.map{|g| "officer.gender.#{g[1]}"}
    cols += Department.column_names.map{|c| "department.#{c}"}
    cols += Incident::DEPARTMENT_UNION_STATEMENT_VALUES.map{|s| "department.statement.#{s[1]}"}
    cols += Incident::DEPARTMENT_UNION_STATEMENT_VALUES.map{|s| "union.statement.#{s[1]}"}
    cols += ["references"]
    CSV.generate do |csv|
      csv << cols
      all.each do |incident|
        oneline = incident.attributes.values_at(*column_names)
        Incident::TAG_VARIABLES.each do |tag|
          eval("Incident::#{tag[0]}").each do |var|
            oneline << eval("incident.#{tag[2]}").include?(var[1])
          end
        end
        Incident::VIC_RACE_VALUES.each do |race|
          oneline << incident.officer_race_list.include?(race[1])
        end
        Incident::VIC_GENDER_VALUES.each do |gender|
          oneline << incident.officer_gender_list.include?(gender[1])
        end
        oneline += incident.department.attributes.values_at(*Department.column_names)
        Incident::DEPARTMENT_UNION_STATEMENT_VALUES.each do |s|
          oneline << incident.department_statement_variety_list.include?(s[1])
          oneline << incident.union_statement_variety_list.include?(s[1])
        end
        referenceString = ""
        incident.references.each do |r|
          referenceString += "#{r.headline}(#{r.url})"
        end
        oneline << referenceString
        csv << oneline
      end
    end
  end

  protected
    def sanity_check
      if self.abuse_force_variety_list.length > 0 and !self.abuse_force
        self.abuse_force = true
      end

      if self.abuse_search_variety_list.length > 0 and !self.abuse_search
        self.abuse_search = true
      end

      if self.abuse_misconduct_variety_list.length > 0 and !self.abuse_misconduct
        self.abuse_misconduct = true
      end

      if self.abuse_intimidation_variety_list.length > 0 and !self.abuse_intimidation
        self.abuse_intimidation = true
      end

      if self.abuse_sexual_variety_list.length > 0 and !self.abuse_sexual
        self.abuse_sexual = true
      end

      if self.abuse_force and self.abuse_force_variety_list.length == 0
        self.abuse_force_variety_list << "Unknown"
      end

      if self.abuse_search and self.abuse_search_variety_list.length == 0
        self.abuse_search_variety_list << "Unknown"
      end

      if self.abuse_misconduct and self.abuse_misconduct_variety_list.length == 0
        self.abuse_misconduct_variety_list << "Unknown"
      end

      if self.abuse_intimidation and self.abuse_intimidation_variety_list.length == 0
        self.abuse_intimidation_variety_list << "Unknown"
      end

      if self.abuse_sexual and self.abuse_sexual_variety_list.length == 0
        self.abuse_sexual_variety_list << "Unknown"
      end

      if self.victim_race_list.length == 0
        self.victim_race_list << "Unknown"
      end

      if self.victim_age_list.length == 0
        self.victim_age_list << "Unknown"
      end

      if self.victim_gender_list.length == 0
        self.victim_gender_list << "Unknown"
      end

      if self.officer_race_list.length == 0
        self.officer_race_list << "Unknown"
      end

      if self.officer_gender_list.length == 0
        self.officer_gender_list << "Unknown"
      end

      if self.officer_year_list.length == 0
        self.officer_year_list << "Unknown"
      end

    end
end

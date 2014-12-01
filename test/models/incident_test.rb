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

require 'test_helper'

class IncidentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

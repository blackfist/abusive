# == Schema Information
#
# Table name: incident_references
#
#  id           :integer          not null, primary key
#  incident_id  :integer
#  reference_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'test_helper'

class IncidentReferenceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

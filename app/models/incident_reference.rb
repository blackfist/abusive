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

class IncidentReference < ActiveRecord::Base
  belongs_to :incident
  belongs_to :reference
end

# == Schema Information
#
# Table name: references
#
#  id              :integer          not null, primary key
#  url             :string
#  date_accessed   :date
#  headline        :string
#  org_name        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  incident_id     :integer
#  publish_date    :date
#  contribution_id :integer
#

class Reference < ActiveRecord::Base
  validates :url, presence: true
  belongs_to :incident, :inverse_of => :references
  belongs_to :contribution, :inverse_of => :references
end

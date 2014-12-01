# == Schema Information
#
# Table name: references
#
#  id            :integer          not null, primary key
#  url           :string
#  date_accessed :date
#  headline      :string
#  org_name      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  incident_id   :integer
#  publish_date  :date
#

require 'test_helper'

class ReferenceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

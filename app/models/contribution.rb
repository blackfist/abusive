# == Schema Information
#
# Table name: contributions
#
#  id             :integer          not null, primary key
#  summary        :text
#  start_year     :integer
#  end_year       :integer
#  start_month    :integer
#  end_month      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  location_state :string
#  location_city  :string
#

class Contribution < ActiveRecord::Base
  has_many :references, :inverse_of => :contribution
  accepts_nested_attributes_for :references
end

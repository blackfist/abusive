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
#  category       :string
#

class Contribution < ActiveRecord::Base
  def self.CATEGORIES
    [["Rehire abuser","rehire"],
    ["Widespread corruption","corruption"],
    ["Preferential treatment","preference"],
    ["Predatory policing","targeting"],
    ["Taunting / Inciting","inciting"]]
  end

  has_many :references, :inverse_of => :contribution
  accepts_nested_attributes_for :references
  validates :category, presence: true, inclusion: { in: self.CATEGORIES.map{|r| r[1] } }


end

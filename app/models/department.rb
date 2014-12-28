# == Schema Information
#
# Table name: departments
#
#  id         :integer          not null, primary key
#  name       :string
#  city       :string
#  county     :string
#  state      :string
#  level      :string
#  notes      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Department < ActiveRecord::Base
  DEPARTMENT_LEVELS = [["Federal","federal"],
    ["State","state"],
    ["County","county"],
    ["City","city"],
    ["Unknown","unknown"],
    ["Other","other"]]

  validates :name, presence: true
  validates :level, presence: true,
    inclusion: {in: DEPARTMENT_LEVELS.map{|r| r[1]}}

  has_many :incidents, :inverse_of => :department
  has_many :contributions, inverse_of: :department


end

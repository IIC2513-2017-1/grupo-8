# == Schema Information
#
# Table name: tournaments
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  season      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  division_id :integer
#

class Tournament < ApplicationRecord
  validates :name, presence: true, length: { minimum: 5 }, uniqueness: true
  validates :description, presence: true
  validates :season, presence: true

  belongs_to :division
end

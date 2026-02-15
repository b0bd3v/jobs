# == Schema Information
#
# Table name: jobs
#
#  id              :bigint           not null, primary key
#  description     :text
#  employment_type :integer
#  location        :string
#  status          :integer
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Job < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 30 }
  validates :status, presence: true

  enum status: %i[draft published]
  enum employment_type: %i[clt pj internship]
end

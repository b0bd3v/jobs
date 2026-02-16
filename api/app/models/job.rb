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

  scope :search_by_term, ->(term) {
    where('LOWER(title) LIKE :term OR LOWER(description) LIKE :term OR LOWER(location) LIKE :term', term: "%#{term.downcase}%")
  }

  enum status: %i[draft published]
  enum employment_type: %i[clt pj internship]
end

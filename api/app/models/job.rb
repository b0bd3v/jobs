# == Schema Information
#
# Table name: jobs
#
#  id              :bigint           not null, primary key
#  description     :text
#  employment_type :integer
#  location        :string
#  publish_at      :datetime
#  status          :integer
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Job < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 30 }
  
  scope :search_by_term, ->(term) {
    where('LOWER(title) LIKE :term OR LOWER(description) LIKE :term OR LOWER(location) LIKE :term', term: "%#{term.downcase}%")
  }

  scope :published, ->() {
    where("publish_at IS NOT NULL AND publish_at <= ?", Time.current).order(publish_at: :desc)
  }

  enum employment_type: %i[clt pj internship]

  def scheduled?
    publish_at.present? && publish_at > Time.current
  end

  def published?
    publish_at.present? && publish_at <= Time.current
  end

  alias_method :scheduled, :scheduled?
  alias_method :published, :published?
end

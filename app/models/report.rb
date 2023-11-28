# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :mentioned, class_name: 'Mention', foreign_key: :mentioned_report_id, inverse_of: :mentioned_report, dependent: :destroy
  has_many :mentioning_reports, through: :mentioned, source: :mentioning_report

  has_many :mentioning, class_name: 'Mention', foreign_key: :mentioning_report_id, inverse_of: :mentioning_report, dependent: :destroy
  has_many :mentioned_reports, through: :mentioning, source: :mentioned_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def create_mentions
    contents = self.content.scan(%r{http://localhost:3000/reports/(\d{1,})})
    return if contents.empty?

    contents.each do |content|
      Mention.create!(mentioned_report_id: self.id, mentioning_report_id: content[0])
    end
  end
end

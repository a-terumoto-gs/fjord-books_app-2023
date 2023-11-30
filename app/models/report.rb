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

  def create_mentions!
    fetched_mention_urls = content.scan(%r{http://localhost:3000/reports/(\d{1,})})
    mention_urls = fetched_mention_urls.uniq
    return if mention_urls.empty?

    mention_urls.each do |mention_url|
      Mention.create!(mentioning_report_id: id, mentioned_report_id: mention_url[0])
    end
  end
end

# frozen_string_literal: true

class Mention < ApplicationRecord
  belongs_to :mentioned_report, class_name: 'Report'
  belongs_to :mentioning_report, class_name: 'Report'

  validates :mentioned_report_id, uniqueness: { scope: :mentioning_report_id, message: 'custom error message' }

  def create_mentions
    contents = @report.content.scan(%r{http://localhost:3000/reports/(\d{1,})})
    return if contents.empty?

    contents.each do |content|
      Mention.create(mentioned_report_id: @report.id, mentioning_report_id: content[0])
    end
  end
end

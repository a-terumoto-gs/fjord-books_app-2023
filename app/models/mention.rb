# frozen_string_literal: true

class Mention < ApplicationRecord
  belongs_to :mentioned_report, class_name: 'Report'
  belongs_to :mentioning_report, class_name: 'Report'

  validates_uniqueness_of :mentioned_report_id, scope: :mentioning_report_id
end


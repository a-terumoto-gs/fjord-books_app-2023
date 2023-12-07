# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  fixtures :users, :reports

  def setup
    @user = users(:alice)
    @report = reports(:first_report)
  end

  test 'editable?' do
    assert @report.editable?(@user)
    assert_not @report.editable?(users(:bob))
  end

  test 'created_on' do
    assert_equal Time.now.to_date, @report.created_on
  end

  test 'save_mentions' do
    first_report = @report
    second_report = reports(:second_report)
    report = @user.reports.build(title: 'mentioning', content: "http://localhost:3000/reports/#{first_report.id}")

    report.save!
    assert_equal report.mentioning_reports.to_a, [first_report]

    report.update!(content: "http://localhost:3000/reports/#{second_report.id}")
    report.mentioning_reports.reload
    assert_equal report.mentioning_reports.to_a, [second_report]
  end
end

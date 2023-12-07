# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  fixtures :users, :reports

  def setup
    @user = users(:alice)
  end

  test 'editable?' do
    @report = reports(:first_report)
    assert @report.editable?(@user)
  end

  test 'created_on' do
    @report = reports(:first_report)
    assert_equal Time.now.to_date, @report.created_on
  end

  test 'save_mentions' do
    @first_report = reports(:first_report)
    @second_report = reports(:second_report)
    @report = @user.reports.build(title: 'mentioning', content: "http://localhost:3000/reports/#{@first_report.id}")

    @report.save!
    assert_equal @report.mentioning_reports.to_a, [@first_report]

    @report.update!(content: "http://localhost:3000/reports/#{@second_report.id}")
    @report.mentioning_reports.reload
    assert_equal @report.mentioning_reports.to_a, [@second_report]
  end
end

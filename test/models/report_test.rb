# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  fixtures :users, :reports

  def setup
    @user = users(:alice)
  end

  test 'editable?' do
    @report = reports(:one)
    assert @report.editable?(@user)
  end

  test 'created_on' do
    @report = reports(:one)
    assert_equal @report.created_at.to_date, @report.created_on
  end

  test 'save_mentions' do
    @one_report = reports(:one)
    @another_report = reports(:two)
    @report = @user.reports.build(title: 'mentioning', content: "http://localhost:3000/reports/#{@one_report.id}")

    @report.save!
    assert_equal @report.mentioning_reports.to_a, [@one_report]

    @report.update!(content: "http://localhost:3000/reports/#{@another_report.id}")
    @report.mentioning_reports.reload
    assert_equal @report.mentioning_reports.to_a, [@another_report]
  end
end

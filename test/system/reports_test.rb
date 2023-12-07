# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  fixtures :users, :reports

  setup do
    @report = reports(:first_report)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    find('h1', text: '本の一覧')
  end

  test '日報一覧表示' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test '日報作成' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: 'わかった！'
    fill_in '内容', with: 'ずっと苦戦してたところが解決できた'
    click_on '登録する'

    assert_selector 'h1', text: '日報の詳細'
    assert_text '日報が作成されました。'
    assert_text 'わかった！'
    assert_text 'ずっと苦戦してたところが解決できた'
    assert_text 'Alice'
    assert Report.find_by(id: @report.id)
  end

  test '日報更新' do
    visit report_url(@report)
    click_on 'この日報を編集', match: :first

    fill_in 'タイトル', with: 'やっぱりわかってなかった'
    fill_in '内容', with: '解決できてなかった'

    click_on '更新する'

    assert_selector 'h1', text: '日報の詳細'
    assert_text '日報が更新されました。'
    assert_text 'やっぱりわかってなかった'
    assert_text '解決できてなかった'
    assert_text 'Alice'
    assert Report.find_by(id: @report.id)
  end

  test '日報削除' do
    visit report_url(@report)
    click_on 'この日報を削除', match: :first

    assert_selector 'h1', text: '日報の一覧'
    assert_text '日報が削除されました。'
    assert_nil Report.find_by(id: @report.id)
  end
end

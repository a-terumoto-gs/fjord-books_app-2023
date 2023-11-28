# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  fixtures :users, :reports

  setup do
    @report = reports(:one)

    visit root_url
    fill_in 'Eメール', with: 'aaa@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    assert_text 'ログインしました。'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should create report' do
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
  end

  test 'should update Report' do
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
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除', match: :first

    assert_selector 'h1', text: '日報の一覧'
    assert_text '日報が削除されました。'
    assert_nil Report.find_by(id: @report.id)
  end
end

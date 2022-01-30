require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let(:task) { FactoryBot.create(:task) }

  it 'タスク一覧が表示されること' do
    visit root_path
    expect(page).to have_content('タスク一覧')
  end

  it 'タスクの作成ができること' do
    visit '/tasks/new'
    fill_in 'タスク名', with: 'hoge'
    fill_in '内容', with: 'foo'
    expect { click_button '登録' }.to change { Task.count }.by(1)

    expect(page).to have_content('タスクを作成しました')
  end

  it 'タスクの削除ができること' do
    visit "/tasks/#{task.id}"
    expect { click_link '削除' }.to change { Task.count }.by(-1)
    expect(page).to have_content('タスクを削除しました')
  end

  it 'タスクの更新ができること' do
    visit "/tasks/#{task.id}"
    click_link '更新ページへ'
    expect(page).to have_content('タスク編集')

    fill_in 'タスク名', with: 'hoge'
    fill_in '内容', with: 'foo'
    click_button '更新'
    expect(page).to have_content('タスクを更新しました')
    expect(task.reload.name).to eq 'hoge'
    expect(task.reload.content).to eq 'foo'
  end
end

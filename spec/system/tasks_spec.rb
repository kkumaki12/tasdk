require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let(:task) { create(:task) }

  it 'タスク一覧が表示されること' do
    visit root_path
    expect(page).to have_content('タスク一覧')
  end

  describe 'タスクの作成' do
    before do
      visit '/tasks/new'
      fill_in 'タスク名', with: 'hoge'
      fill_in '内容', with: 'foo'
      fill_in '終了期限', with: Time.zone.now
    end

    it 'タスクの作成ができること' do
      expect { click_button '登録' }.to change { Task.count }.by(1)
      expect(page).to have_content('タスクを作成しました')
    end

    it 'タスクのステータスの初期値が未着手であること' do
      click_button '登録'
      expect(page).to have_content('未着手')
    end
  end

  it 'タスクの削除ができること' do
    visit "/tasks/#{task.id}"
    expect { click_link '削除' }.to change { Task.count }.by(-1)
    expect(page).to have_content('タスクを削除しました')
  end

  describe 'タスクの更新' do
    before do
      visit "/tasks/#{task.id}"
      click_link '更新ページへ'
    end

    it 'タスク編集ページに行けること' do
      expect(page).to have_content('タスク編集')
    end

    it 'タスクの更新ができること' do
      fill_in 'タスク名', with: 'hoge'
      fill_in '内容', with: 'foo'
      click_button '更新'
      expect(page).to have_content('タスクを更新しました')
      expect(task.reload.name).to eq 'hoge'
      expect(task.reload.content).to eq 'foo'
    end
  end

  describe 'バリデーションエラー' do
    it 'nameがないとき新規作成ができないこと' do
      visit '/tasks/new'
      fill_in '内容', with: 'hoge'
      find('input[id="task_expiration_deadline"]').set(1.day.from_now)
      click_button '登録'
      expect(page).to have_content('タスク名を入力してください')
    end

    it 'contentがないとき新規作成ができないこと' do
      visit '/tasks/new'
      fill_in 'タスク名', with: 'hoge'
      find('input[id="task_expiration_deadline"]').set(1.day.from_now)
      click_button '登録'
      expect(page).to have_content('内容を入力してください')
    end

    it 'expiration_deadlineがないとき新規作成ができないこと' do
      visit '/tasks/new'
      fill_in 'タスク名', with: 'hoge'
      fill_in '内容', with: 'hoge'
      click_button '登録'
      expect(page).to have_content('終了期限を入力してください')
    end
  end

  describe '並び順' do
    before do
      Task.create(name: 'name1', content: 'content1', expiration_deadline: 9.days.from_now, created_at: Time.zone.now)
      Task.create(name: 'name2', content: 'content2', expiration_deadline: 8.days.from_now, created_at: 1.day.from_now)
      Task.create(name: 'name3', content: 'content3', expiration_deadline: 7.days.from_now, created_at: 1.day.ago)
    end

    it '作成されたタスクが作成日時の降順になっていること' do
      visit '/tasks'
      within '.tasks' do
        task_names = all('.task-name').map(&:text)
        expect(task_names).to eq %w(name2 name1 name3)
      end
    end

    it 'タスクを終了時刻の近い順に並び替えできること' do
      visit '/tasks'
      select '終了期限の近い順', from: 'sort'
      click_button 'ソート'
      within '.tasks' do
        task_names = all('.task-name').map(&:text)
        expect(task_names).to eq %w(name3 name2 name1)
      end
    end
  end

  describe '検索' do
    before do
      Task.create(name: 'name1', content: 'content1', expiration_deadline: 9.days.from_now, created_at: Time.zone.now, status: 'not_started_yet')
      Task.create(name: 'name2', content: 'content2', expiration_deadline: 8.days.from_now, created_at: 1.day.from_now, status: 'under_start')
      visit '/tasks'
    end

    it 'タスク名で検索ができること' do
      fill_in 'タスク名 は以下を含む', with: '1'
      click_button '検索'
      within '.tasks' do
        task_names = all('.task-name').map(&:text)
        expect(task_names).to eq %w(name1)
      end
    end

    it 'ステータスで検索ができること' do
      check 'q_status_eq_any_1'
      click_button '検索'
      within '.tasks' do
        task_names = all('.task-name').map(&:text)
        expect(task_names).to eq %w(name2)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーションテスト' do
    let(:task) { FactoryBot.create(:task) }

    it 'name, contentがあれば有効なこと' do
      expect(task).to be_valid
    end

    it 'nameがなければ無効なこと' do
      task.name = nil
      task.valid?
      expect(task.errors[:name]).to include('を入力してください')
    end

    it 'contentがなければ無効なこと' do
      task.content = nil
      task.valid?
      expect(task.errors[:content]).to include('を入力してください')
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションテスト' do
    let(:user) { build(:user) }
    context 'name, email, password があるとき' do
      it 'ユーザーの作成が成功すること' do
        expect(user).to be_valid
      end
    end
  end
end

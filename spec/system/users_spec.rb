require "rails_helper"

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }
  describe "ログイン" do
    before do
      visit login_path
    end

    context "正しい情報が入力されているとき" do
      it "ログインできること" do
        fill_in "Email", with: "#{user.email}"
        fill_in "Password", with: "#{user.password}"
        click_button "ログイン"
        expect(page).to have_content("ユーザー")
      end
    end

    context "Emailが大文字のとき" do
      it "ログインできること" do
        fill_in "Email", with: "#{user.email.upcase}"
        fill_in "Password", with: "#{user.password}"
        click_button "ログイン"
        expect(page).to have_content("ユーザー")
      end
    end

    context "Emailが間違っているとき" do
      it "ログインできないこと" do
        fill_in "Email", with: "hoge@bar.com"
        fill_in "Password", with: "#{user.password}"
        click_button "ログイン"
        expect(page).to have_content("メールアドレスかパスワードが間違っています")
      end
    end

    context "Passwordが間違っているとき" do
      it "ログインできないこと" do
        fill_in "Email", with: "#{user.email}"
        fill_in "Password", with: "hogehoge"
        click_button "ログイン"
        expect(page).to have_content("メールアドレスかパスワードが間違っています")
      end
    end
  end
end

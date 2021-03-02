require 'rails_helper'

RSpec.describe 'ユーザーログイン機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  it 'ログアウト状態では、ヘッダーに新規登録/ログインボタンが表示されること' do
    # トップページに遷移する
    visit root_path
    # ヘッダーに'新規登録画'が表示される
    expect(page).to have_content('新規登録')
    # ヘッダーに'ログイン'が表示される
    expect(page).to have_content('ログイン')
  end

  it 'ヘッダーの新規登録/ログインボタンをクリックすることで、各ページに遷移できること' do
    # トップページに遷移する
    visit root_path
    # ヘッダーの新規登録をクリックすることで、新規登録画面に遷移出来る
    click_on('新規登録')
    # トップページに遷移する
    visit root_path
    # ヘッダーのログインをクリックすることでサインインページへ遷移できる
    click_on('ログイン')
  end

  it 'ログイン状態では、ヘッダーにユーザーのニックネーム/ログアウトボタンが表示されること' do
    # サインインする
    sign_in(@user)
    # ヘッダーにユーザーのニックネームが表示される
    expect(page).to have_content(@user.nickname.to_s)
    # ヘッダーにログアウトボタンが表示される
    expect(page).to have_content('ログアウト')
  end

  it 'ヘッダーのログアウトボタンをクリックすることで、ログアウトができること' do
    # サインインする
    sign_in(@user)
    # ログアウトボタンをクリックすることでログアウトができる
    click_on('ログアウト')
    expect(current_path).to eq(root_path)
  end
end

crumb :root do
  link "Home", root_path
end

crumb :sign_up do
  link "新規登録", new_user_registration_path
end

crumb :sign_in do
  link "ログイン画面", new_user_session_path
end

crumb :new do
  link "出品画面", new_product_path
end

crumb :product_show do |product|
  link "商品詳細画面", product_path(product.id)
end

crumb :product_buy do |product|
  link "商品購入画面", product_buys_path
  parent :product_show, product
end

crumb :product_edit do |product|
  link "商品編集画面", edit_product_path(product.id)
  parent :product_show, product
end
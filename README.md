# テーブル設計

## users テーブル

| Column                | Type    | Options                   |
| --------------------- | ------- | ------------------------- |
| nickname              | string  | null: false, unique: true |
| email                 | string  | null: false, unique: true |
| password              | string  | null: false               |
| password_confirmation | string  | null: false               |
| family_name           | string  | null: false               |
| given_name            | string  | null: false               |
| family_name_kana      | string  | null: false               |
| given_name_kana       | string  | null: false               |
| birthday              | integer | null: false               |

### Association

- has_many :products
- has_many :buys

## products テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| product_name | string     | null: false                    |
| category     | string     | null: false                    |
| status       | string     | null: false                    |
| description  | text       | null: false                    |
| price        | integer    | null: false                    |
| user_id      | references | null: false, foreign_key: true |
| image        |            | Active Storage                 |

### Association

- belongs_to :user
- has_one :buy

## buys テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefectures   | string     | null: false                    |
| municipality  | text       | null: false                    |
| house_number  | text       | null: false                    |
| building      | text       | null: false                    |
| phone_number  | integer    | null: false                    |
| user_id       | references | null: false, foreign_key: true |
| product_id    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :product
- has_one :address

## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| shipping_days | string     | null: false                    |
| shipping_area | string     | null: false                    |
| shipping_cost | string     | null: false                    |
| buy_id        | references | null: false, foreign_key: true |

### Association

- belongs_to :buy
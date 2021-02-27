# テーブル設計

## users テーブル

| Column                | Type    | Options                   |
| --------------------- | ------- | ------------------------- |
| nickname              | string  | null: false,              |
| email                 | string  | null: false, unique: true |
| encrypted_password    | string  | null: false               |
| family_name           | string  | null: false               |
| given_name            | string  | null: false               |
| family_name_kana      | string  | null: false               |
| given_name_kana       | string  | null: false               |
| birthday              | date    | null: false               |

### Association

- has_many :products
- has_many :buys

## products テーブル

| Column           | Type        | Options                        |
| ---------------- | ----------- | ------------------------------ |
| product_name     | string      | null: false                    |
| description      | text        | null: false                    |
| price            | integer     | null: false                    |
| category_id      | integer     | null: false                    |
| status_id        | integer     | null: false                    |
| shipping_days_id | integer     | null: false                    |
| shipping_area_id | integer     | null: false                    |
| shipping_cost_id | integer     | null: false                    |
| user             | references  | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :buy

## buys テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |

| user          | references | null: false, foreign_key: true |
| product       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :product
- has_one :address

## addresses テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| postal_code    | string     | null: false                    |
| municipality   | string     | null: false                    |
| house_number   | string     | null: false                    |
| phone_number   | string     | null: false                    |
| building       | string     |                                |
| prefectures_id | integer    | null: false                    |
| buy            | references | null: false, foreign_key: true |

### Association

- belongs_to :buy
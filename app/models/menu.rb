class Menu < ApplicationRecord
  has_many :menu_categories, dependent: :destroy
  has_many :categories, through: :menu_categories

  has_many :order_details
  has_many :orders, through: :order_details

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
end

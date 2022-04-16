class Menu < ApplicationRecord
  has_many :menu_categories, dependent: :destroy
  has_many :categories, through: :menu_categories

  has_many :order_details
  has_many :orders, through: :order_details

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0.01}
end

class Menu < ApplicationRecord
  has_many :menu_categories, dependent: :destroy
  has_many :categories, through: :menu_categories

  has_many :order_details
  has_many :orders, through: :order_details

<<<<<<< HEAD
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
=======
  validates :name, presence: true
>>>>>>> origin/main
end

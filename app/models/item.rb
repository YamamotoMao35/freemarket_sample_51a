class Item < ApplicationRecord
  validates :name, length: {maximum: 40}
  validates :description, length: {maximum: 1000}
  validates :price, numericality: {only_integer: true,greater_than: 300, less_than: 9999999}
  
  has_many_attached :images
  has_one :shipment, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :brand, optional: true
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true
  accepts_nested_attributes_for :shipment
  accepts_nested_attributes_for :brand
  has_many :items_categories, dependent: :destroy
  has_many :categories, through: :items_categories
  accepts_nested_attributes_for :items_categories, allow_destroy: true

  enum size: {"--": "", "XXS以下": 1, "XS(SS)": 2, "S": 3, "M": 4,"L": 5,"XL(LL)": 6, "2XL(3L)": 7, "3XL(4L)": 8, "4XL(5L)以上": 9,"FREESIZE": 10}, _suffix: true

  enum item_status: {"---": "","新品、未使用": 1, "未使用に近い": 2,"目立った傷や汚れなし": 3,"やや傷や汚れあり": 4,"傷や汚れあり": 5, "全体的に状態が悪い": 6}, _suffix: true
end

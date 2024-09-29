class Product < ApplicationRecord
  include Favoritable
  # Ordenar productos
  ORDER_BY = {
    newest: "created_at DESC",
    cheapest: "price ASC",
    expensivest: "price DESC"
  }

  has_one_attached :photo
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true

  belongs_to :category
  belongs_to :user, default: -> {Current.user}
  has_many :favorites, dependent: :destroy

  def owner?
    user_id == Current.user&.id
  end



end

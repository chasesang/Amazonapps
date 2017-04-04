class Review < ApplicationRecord
  belongs_to :product
  validates :rating, presence: true


  validates(:body,{ presence: true, length: { minimum: 3 } })
  validates(:rating, { presence: true,
                          numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }})

end

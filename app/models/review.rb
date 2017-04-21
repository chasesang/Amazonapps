class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  validates :rating, presence: true


  validates(:body,{ presence: true, length: { minimum: 3 } })
  validates(:rating, { presence: true,
                          numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }})
  def liked_by?(user)
    likes.exists?(user: user)
  end

  def like_for(user)
    likes.find_by(user: user)

  end



end

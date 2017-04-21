class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :favouritors,  through: :favourites, source: :user

  validates :title, presence: true, uniqueness: {case_sensitive: false}
  validates(:price, { presence: true,
                            numericality: { greater_than: 0 }})
  validates(:description,{ presence: true, length: { minimum: 10 } })

  before_save :set_defaults, :titleize_title

  def favourited_by?(user)
    favourites.exists?(user: user)
  end

  def favourite_for(user)
    favourites.find_by(user: user)
  end


  def self.search(string)
    self.where(["title ILIKE? or description ILIKE?", "%#{string}%","%#{string}%"])
  end

  def self.search(find)
     where('title ILIKE? OR body ILIKE ?',"%#{find}%", "%#{find}%").
     order('title')
   end

  def set_defaults
    self.price ||= 1
    end

  def titleize_title
    self.title =title.titleize if title.present?
    end

 end

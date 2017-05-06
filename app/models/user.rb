class User < ApplicationRecord
  has_secure_password
  has_many :products
  has_many :reviews, dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review
  has_many :favourites, dependent: :destroy
  has_many :favourited_product, through: :favourites, source: :product


  validates(:first_name, { presence: true })
  validates(:last_name, { presence: true })
  validates(:email, { presence: true })


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                        uniqueness: true,
                        case_sensitive: false,
                        format: VALID_EMAIL_REGEX

  before_validation :downcase_email
  before_create :generate_api_token

    def self.search(search_term)
      where(['first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?', "%#{search_term}%", "%#{search_term}%", "%#{search_term}%"])
    end

    def self.created_after(date)
      where(['created_at > ?', "#{date}"])
    end

    def self.is_not(name)
      where('first_name != ? AND last_name != ?', "#{name}", "#{name}")
    end
    private
    def downcase_email
      self.email.downcase! if email.present?
    end
    def full_name
      "#{first_name} #{last_name}".titleize
    end
    def generate_api_token
    loop do
    self.api_token = SecureRandom.urlsafe_base64(32)
    break unless User.exists?(api_token: self.api_token)
  end
  end
end

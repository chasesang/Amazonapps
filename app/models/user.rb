class User < ApplicationRecord
  has_secure_password
  has_many :products
  has_many :reviews

  validates(:first_name, { presence: true })
    validates(:last_name, { presence: true })



      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      validates :email, presence: true,
                        uniqueness: { case_sensitive: false },
                        format: VALID_EMAIL_REGEX

      before_validation :downcase_email

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

end

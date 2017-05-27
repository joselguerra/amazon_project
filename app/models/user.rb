class User < ApplicationRecord
  has_secure_password
  has_many :products
  has_many :reviews, dependent: :nullify
  validates(:first_name, presence: { message: 'must be provided' })
  validates(:last_name, presence: { message: 'must be provided' })
  validates(:email, presence: { message: 'must be provided' })

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: VALID_EMAIL_REGEX

  before_validation :downcase_email

  def self.search(search_term)
    # where(['first_name || last_name || email LIKE ?', "%#{search_term}%"])
    find("%#{search_term}%", "first_name || last_name || email", exact: true)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

    def downcase_email
      self.email&.downcase!
    end
end

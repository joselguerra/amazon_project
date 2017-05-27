class Product < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :user, optional: true
  validates(:title, presence: { message: 'must be provided' }, uniqueness: { case_sensitive: false }, exclusion: { in: %w(Apple Microsoft Sony)})

  validates(:description, presence: { message: 'must be provided' }, length: { minimum: 10 })

  validates(:price, numericality: { greater_than: 0 })

  has_many :reviews, dependent: :destroy

  after_initialize :set_price
  before_validation :capitalize_title

  def self.search(str)

    (where(["title ILIKE ?", "%#{str}%"]) + where(["description ILIKE ?", "%#{str}%"])).uniq

    # find_by_sql(SELECT title, description
    #             FROM products
    #             WHERE title OR description =
    #             ORDER BY
    #             title ASC,
    #             CASE title ILIKE "%#{str}%" WHEN true )

    #
    # where(["title ILIKE ?", "%#{str}%"]) + where(["description ILIKE ?", "%#{str}%"])

    # .order( "expiration_date <?", Time.current, :desc )
#####
    # where(['title OR description ILIKE ?', "%#{str}%"]).order("title ILIKE ?", "%#{str}%")
#####
  # find_by_sql(SELECT ROW_NUMBER() OVER (ORDER BY title, description) AS "No",
  # title AS "Product Name", description AS "Product Description"
  # FROM Product WHERE (title ILIKE "%#{str}%" OR description ILIKE '%${str}%'))
  end

  private

  def set_price
    self.price ||= 1
  end

  def capitalize_title
    self.title = title.capitalize if title.present?
  end

end

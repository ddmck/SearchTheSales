class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  has_many :wishlist_items
  has_many :products, through: :wishlist_items
  has_many :orders
  has_one :basket
  before_create -> do 
    puts "YO!"
    self.uid = SecureRandom.uuid 
    skip_confirmation! 
  end
  after_create :create_basket

  


  # Relations
  has_many :posts

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Pagination
  paginates_per 100

  # Validations
  # :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def wishlist
    products.to_a
  end

  def basket_items
    basket.products
  end

  def create_basket
    super
  end
end

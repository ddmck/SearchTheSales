class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  has_many :wishlist_items
  has_many :products, through: :wishlist_items
  has_many :orders
  has_many :messages
  has_one :basket
  has_many :recommendations
  belongs_to :gender
  before_create -> do
    self.uid = SecureRandom.uuid if self.provider == 'email'
    skip_confirmation!
  end
  after_create :create_basket
  after_create :send_welcome_email
  after_create :send_welcome_message

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

  def set_gender
	  puts first_name
    detector = GenderDetector.new
    gndr =  detector.get_gender(first_name, :great_britain).to_s
    if gndr == "male"
      self.gender = Gender.find_by_name("male")
    elsif gndr == "female"
      self.gender = Gender.find_by_name("female")
    end
  end

  def gender_string
    if gender
      gender.name
    else
      ""
    end
  end

  def first_name
    name.split().first
  end

  def wishlist
    products.to_a
  end

  def basket_items
    basket.products
  end

  def create_basket
    super
  end

  def send_welcome_email
    NewUserMailer.new(self).deliver
  end

  def replied_to
    if self.messages.last
      self.messages.last.sender_id != self.id
    end
  end

  def last_message_time
    self.last_sent_message.try(:created_at) || Time.zone.at(0)
  end

  def last_sent_message
    self.messages.where(sender_id: self.id).last
  end

  def self.most_recent
    self.all.sort_by {|user| user.last_message_time}.reverse
  end

  def send_welcome_message
    self.messages.build(sender_id: Admin.last.id, text: "Hey #{self.name.split(' ')[0]}!").save
    self.messages.build(sender_id: Admin.last.id, text: "Welcome to HowAbout. I'm here to help you find fashion items you love").save
    self.messages.build(sender_id: Admin.last.id, text: "Are you looking for any items in particular at the moment or just general inspiration?").save
  end

  def send_push_notification(text)
    notification = Houston::Notification.new(device: self.push_token)
    notification.alert = text

    # Notifications can also change the badge count, have a custom sound, have a category identifier, indicate available Newsstand content, or pass along arbitrary data.
    notification.badge = 57
    notification.sound = "sosumi.aiff"
    notification.category = "INVITE_CATEGORY"
    notification.content_available = true
    notification.custom_data = {type: "chat"}

    # And... sent! That's all it takes.
    APN.push(notification)
  end
end

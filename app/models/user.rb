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
  after_create :send_welcome_email

  


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

  def render_anywhere(partial, assigns = {})
    view = ActionView::Base.new(ActionController::Base.view_paths, assigns)
    view.extend ApplicationHelper
    view.render(:partial => partial)
  end 

  def send_welcome_email


    mg_client = Mailgun::Client.new(ENV['MAILGUN_API_KEY'])
    @html = render_anywhere('mailgun_templates/welcome', {:email => email})
    puts @html.to_str.class
    # Define your message parameters
    message_params = {:from    => "Bertie Wilson <customercare@fetchmyfashion.com>",
                      :to      => email,
                      :subject => 'Welcome to Fetch My Fashion!',
                      :text    => '<h1>Hello</h1><h2>buy things</h2><h3>PrEtTy ThInGs!</h3>', 
                      :html    => @html.to_str
                    }
    # Send your message through the client
    mg_client.send_message "mg.fetchmyfashion.com", message_params
  end
end

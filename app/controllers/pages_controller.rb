class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home
    # if get_current_user
    #   puts "Current user is: #{get_current_user.id}" 
    # else
    #   puts "No user!"
    # end
    # @stores = Store.first(4)
    # @brands = Brand.first(4)
    # @products = Product.first(4)
    # @wishlist = current_user.wishlist if current_user
    # @basket = current_user.basket if current_user
  end

  def inside
  end

  def posts
    @posts = Post.paginate(page: params[:page], per_page: 50)
  end

  def show_post
    @post = Post.friendly.find(params[:id])
  rescue
    redirect_to root_path
  end

  def email
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]

    if @name.blank?
      flash[:alert] = 'Please enter your name before sending your message. Thank you.'
      render :contact
    elsif @email.blank? || @email.scan(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i).size < 1
      flash[:alert] = 'You must provide a valid email address before sending your message. Thank you.'
      render :contact
    elsif @message.blank? || @message.length < 10
      flash[:alert] = 'Your message is empty. Requires at least 10 characters. Nothing to send.'
      render :contact
    elsif @message.scan(/<a href=/).size > 0 || @message.scan(/\[url=/).size > 0 || @message.scan(/\[link=/).size > 0 || @message.scan(/http:\/\//).size > 0
      flash[:alert] = "You can't send links. Thank you for your understanding."
      render :contact
    else
      ContactMailer.contact_message(@name, @email, @message).deliver
      redirect_to root_path, notice: 'Your message was sent. Thank you.'
    end
  end
end

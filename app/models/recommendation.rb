class Recommendation < ActiveRecord::Base
  belongs_to :user
  has_many :recommendation_items

  def sender_name
    Admin.find(sender_id).name
  end
end

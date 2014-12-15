class FeatureLink < ActiveRecord::Base
  belongs_to :feature
  validates_presence_of :name, :link_url, :feature_id
end

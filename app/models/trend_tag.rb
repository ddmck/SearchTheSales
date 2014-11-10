class TrendTag < ActiveRecord::Base
  belongs_to :product
  belongs_to :trend
end

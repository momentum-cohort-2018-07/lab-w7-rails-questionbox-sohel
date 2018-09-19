class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  paginates_per 5
  include PgSearch
end

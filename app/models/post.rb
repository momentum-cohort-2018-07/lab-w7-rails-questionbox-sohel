class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    validates :body, presence: true
    paginates_per 10
    
end

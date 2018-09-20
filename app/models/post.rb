class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    validates :body, presence: true
    paginates_per 10
    include PgSearch
    
    pg_search_scope :search_post, against: [:body]
    pg_search_scope :search_all_variants,
        against: [:body, :user_id],
        using: {
            tsearch: { dictionary: 'english' }
        }
    
    pg_search_scope :search_all_partial_matches,
        against: [:body, :user_id],
        using: {
            tsearch: { prefix: true }
    }    
end

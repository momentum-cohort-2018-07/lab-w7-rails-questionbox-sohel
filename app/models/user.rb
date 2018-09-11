class User < ApplicationRecord
    has_secure_token :api_token
    has_secure_password
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true, length: {minimum: 5}
    has_many :posts, dependent: :destroy
    has_many :answers, dependent: :destroy
end

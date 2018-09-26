class User < ApplicationRecord
    has_secure_token :api_token
    has_secure_password
    validates :username, uniqueness: true
    validates :password, presence: true, length: {minimum: 5}, allow_nil: true
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_one_attached :photo

    

    def self.send_weekly_email
        posts = Post.where("created_at::date <= ?", Date.today - 7.to_i).select(:body, :question)
            if posts.count > 1
                User.select(:id, :email).find_each do |u|
                    UserMailer.delay.send_weekly_email(u.email, posts)
                end
            end
    end

    private
    
    def params
        params.permit(:body, :question)
    end

end

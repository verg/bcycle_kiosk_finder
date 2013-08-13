class User < ActiveRecord::Base
  has_many :locations, foreign_key: "user_id", dependent: :destroy
end

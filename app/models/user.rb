class User < ApplicationRecord
  has_many :projects, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false}
  validates :password, presence: true, length: { minimum: 8, maximum: 64 }, allow_nil: true
  validates :username, length: { minimum: 4, maximum: 50 }, uniqueness: {case_sensitive: false}, allow_blank: true
  validates :time_zone, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
      data = access_token.info
      user = User.where(provider: access_token.provider, uid: access_token.uid ).first
      if user
        return user
      else
        registered_user = User.where(email: access_token.info.email).first
        if registered_user
          return registered_user
        else
          user = User.create(name: data["name"],
            provider:access_token.provider,
            email: data["email"],
            uid: access_token.uid ,
            password: Devise.friendly_token[0,20],
          )
        end
     end
  end

  def nickname
    if self.username?
      self.username
    else
      self.email
    end
  end
end

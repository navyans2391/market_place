class User < ApplicationRecord
    validates :email, uniqueness: true
    validates_format_of :email, with: /@/
    validates :password_digest, presence: true

    #  it will offer mehtod ActiveModel::SecurePassword::has_secure_password
    #  it will crack the password for us
    has_secure_password

    has_many :products, dependent: :destroy
end

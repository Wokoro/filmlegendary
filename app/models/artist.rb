class Artist < ApplicationRecord
    has_many :musics

    validates :name, length: { minimum: 2 }
    validates :sex, inclusion: { in: %w(male female), message: "%{value} is not a valid sex" }
    validates :biography, length: { maximum: 500,  message: "%{count} characters is the maximum allowed" }
    validates :sex, presence: true
    validates :name, :email, :phone_number, uniqueness: true, presence: true
end

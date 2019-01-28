class Admin < ApplicationRecord
    has_many :musics
    has_many :videos
    has_many :news

    validates :name, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
end

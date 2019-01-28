class Music < ApplicationRecord
    belongs_to :artist, optional: true
    belongs_to :admin, optional: true
end

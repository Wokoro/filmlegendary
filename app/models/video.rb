class Video < ApplicationRecord
    belongs_to :admin, optional: true
end

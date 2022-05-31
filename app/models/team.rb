class Team < ApplicationRecord
    has_many :players
    validates :name, presence: true, length: { minimum: 3, maximum: 50 }
    validates :town, presence: true, length: { minimum: 3, maximum: 50 }
end

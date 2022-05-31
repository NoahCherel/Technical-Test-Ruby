class Player < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    enum player_class: {
        DPS: "DPS",
        Tank: "Tank",
        Healer: "Healer"
    }
    validates :player_class, presence: true
end

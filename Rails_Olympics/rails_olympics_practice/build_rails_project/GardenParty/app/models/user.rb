class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true

    has_many :gardens, 
        primary_key: :id,
        foreign_key: :garden_owner_id,
        class_name: :Garden 

    has_many :flowers,
        primary_key: :id,
        foreign_key: :gardener_id,
        class_name: :Flower 

    has_many :flowers_in_all_gardens,
        through: :gardens,
        source: :flowers 

    has_many :gardens_with_my_flowers,
        through: :flowers,
        source: :garden 



end

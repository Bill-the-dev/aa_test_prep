class Flower < ApplicationRecord

    validates :flower_type, presence: true 

    belongs_to :gardener,
        primary_key: :id,
        foreign_key: :gardener_id,
        class_name: :User 

    belongs_to :garden, 
        primary_key: :id, 
        foreign_key: :garden_id,
        class_name: :Garden 


end

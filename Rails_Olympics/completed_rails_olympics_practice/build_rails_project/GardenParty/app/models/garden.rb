class Garden < ApplicationRecord
    validates :name, presence: true, uniqueness: {scope: :garden_owner_id} 
        # w/in scope of ?
    validates :size, presence: true

    belongs_to :garden_owner,
        primary_key: :id,
        foreign_key: :garden_owner_id,
        class_name: :User 

    has_many :flowers,
        primary_key: :id,
        foreign_key: :flower_type,
        class_name: :Flower 


end

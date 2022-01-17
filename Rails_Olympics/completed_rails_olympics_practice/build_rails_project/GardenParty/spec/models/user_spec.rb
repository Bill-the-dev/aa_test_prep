require 'rails_helper'

RSpec.describe User, type: :model do

  subject { User.create(username: "AppleSauce") }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should have_many(:gardens).class_name(:Garden) }
  it { should have_many(:flowers).class_name(:Flower) }
  it { should have_many(:flowers_in_all_gardens).through(:gardens).source(:flowers) }
  it { should have_many(:gardens_with_my_flowers).through(:flowers).source(:garden) }
end

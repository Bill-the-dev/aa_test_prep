require 'rails_helper'

RSpec.describe Flower, type: :model do
  it { should validate_presence_of(:flower_type) }
  it { should belong_to(:gardener).class_name(:User) }
  it { should belong_to(:garden).class_name(:Garden) }
end

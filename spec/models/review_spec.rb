require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'Validations' do

    def valid_attributes(new_attributes = {})
    { rating: 3,
      body: 'This is the test for validations'
    }.merge(new_attributes)
    end

    it 'requires a star counting' do

      r= Review.new(valid_attributes({rating: nil}))
      r.valid?
      expect(r).to be_invalid
    end
    it 'requires the rating to be b/w 1 and 5' do
      r1= Review.new(valid_attributes({rating: 1}))
      r1.valid?
      expect(r1).to be_valid

      r2= Review.new(valid_attributes({rating: 2}))
      r2.valid?
      expect(r2).to be_valid


      r3= Review.new(valid_attributes({rating: 5}))
      r3.valid?
      expect(r3).to be_valid

      r4= Review.new(valid_attributes({rating: 9}))
      r4.valid?
      expect(r4).to be_invalid
    end



  end










end

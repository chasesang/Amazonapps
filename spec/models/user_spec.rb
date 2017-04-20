require 'rails_helper'

RSpec.describe User, type: :model do

  def valid_attributes(new_attributes = {})
  { first_name: 'John',
    last_name:  'Smith',
    email:      'john@smith.com',
    password:   'supersecret'
  }.merge(new_attributes)
  end
  describe "Validations" do
    it 'requies a first name' do
      user = User.new({
        first_name: nil,
        last_name: 'Saget',
        email: 'bob@example.com',
        password: '123'
        })
        expect(user).to be_invalid
    end



    it 'requies a last name' do
      user = User.new({
        first_name: 'Bob',
        last_name: nil,
        email: 'bob@example.com',
        password: '123'
        })
        expect(user).to be_invalid
    end


    it 'requires an email' do
      user = User.new({
        first_name: 'Bob',
        last_name: 'nil',
        email: nil,
        password: '123'
        })
        expect(user).to be_invalid
    end


    it 'requires an uniquay email' do
      User.create ({
        first_name: 'Bob',
        last_name: 'nil',
        email: 'bob@example.com',
        password: '123'
        })

      u = User.new({
        first_name: 'Bob',
        last_name: 'nil',
        email: 'bob@example.com',
        password: '123'
        })

      u.valid?
      #
      # user = User.new(valid_attributes)
      # user_1 = User.new(valid_attributes)
      #
      # expect(user_2.errors).to have_key(:email)


      expect(u). to be_invalid
    end
  end

    describe 'full_name method' do
      it 'returns the first_name and last_nam concatenated and titleized' do
        bob_sagat ="Bab Saget"
        user = User.new(valid_attributes)
        expect(user)

      end
    end
end

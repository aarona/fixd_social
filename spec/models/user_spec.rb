require 'rails_helper'

RSpec.describe User, type: :model do
  context "when created" do
    let(:user) { subject }

    it "requires an email" do
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include "Email can't be blank"
    end
    
    it "requires a name" do
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include "Name can't be blank"
    end
    
    it "requires a registration data" do
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include "Registered at can't be blank"
    end
  end

  context "when an existing user with the same email already exists" do
    let(:existing_email) { "existing@example.com" }
    let!(:existing_user) { create(:user, email: existing_email) }
    let(:user) { build(:user, email: existing_email) }

    it "requires the email addresses to be unique" do
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include "Email has already been taken"
    end
  end
end

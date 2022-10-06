require 'rails_helper'

RSpec.describe "Users", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Post. As you add validations to Post, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      offset: 0,
      limit: 3
    }
  }

  describe "GET /show" do
    let(:user) { FactoryBot.create(:user) }

    before do
      9.times do
        FactoryBot.create(:post, user: user)
      end
    end

    context "passing paging parameters" do
      before do
        get user_url(user, valid_attributes), as: :json
      end

      it "renders a successful response" do
        expect(response).to be_successful
      end
  
      it "returns the user's feed" do
        data = JSON.parse(response.body)
        expect(data.length).to eq 3
      end
      
      context "requesting the end of the user's posts" do
        let(:valid_attributes) {
          {
            offset: 5,
            limit: 5
          }
        }

        it "renders a successful response" do
          expect(response).to be_successful
        end

        it "returns the last of the user's feed" do
          data = JSON.parse(response.body)
          expect(data.length).to eq 4
        end
      end
    end

    context "passing no parameters" do
      it "should get the first 5 posts of the user's feed." do
        get user_url(user), as: :json
        expect(response).to be_successful
  
        data = JSON.parse(response.body)
        expect(data.length).to eq 5
      end
    end
  end
end

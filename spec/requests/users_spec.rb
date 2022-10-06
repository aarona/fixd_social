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

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # PostsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "GET /show" do
    let(:user) { FactoryBot.create(:user) }

    before do
      9.times do
        FactoryBot.create(:post, user: user)
      end
    end

    it "renders a successful response" do
      get user_url(user, valid_attributes), headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it "returns the user's feed" do
      get user_url(user, valid_attributes), headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    context "passing no parameters" do
      it "should get the first 5 posts of the user's feed." do
        get user_url(user), headers: valid_headers, as: :json
        expect(response).to be_successful
  
        data = JSON.parse(response.body)
        expect(data.length).to eq 5
      end
    end

    context "requesting the end of the user's posts" do
      let(:valid_attributes) {
        {
          offset: 5,
          limit: 5
        }
      }

      it "renders a successful response" do
        get user_url(user, valid_attributes), headers: valid_headers, as: :json
        expect(response).to be_successful
      end

      it "returns the last of the user's feed" do
        get user_url(user, valid_attributes), headers: valid_headers, as: :json
        expect(response).to be_successful

        data = JSON.parse(response.body)
        expect(data.length).to eq 4
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { FactoryBot.create(:user) }
  # This should return the minimal set of attributes required to create a valid
  # Post. As you add validations to Post, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      title: "Test Post Title",
      body: "Test Post Body",
      user_id: user.id
    }
  }

  let(:invalid_attributes) {
    {
      title: nil,
      body: nil,
      user_id: nil
    }
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # PostsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Post" do
        expect {
          post posts_url,
               params: { post: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Post, :count).by(1)
      end

      it "renders a JSON response with the new post" do
        post posts_url,
             params: { post: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Post" do
        expect {
          post posts_url,
               params: { post: invalid_attributes }, as: :json
        }.to change(Post, :count).by(0)
      end

      it "renders a JSON response with errors for the new post" do
        post posts_url,
             params: { post: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "GET /show" do
    let(:the_post) { FactoryBot.create(:post) }

    it "renders a successful response" do
      get post_url(the_post), as: :json
      expect(response).to be_successful
    end

    xit "returns the post and its related comments" do
      get post_url(the_post), as: :json
        data = JSON.parse(response.body)

        expect(response.status).to eq 200
        expect(data["errors"]).to be nil
        # puts data
    end

    context "the post does not exist" do
      before do
        the_post.destroy
      end
      
      it "returns a 404 error" do
        get post_url(the_post), as: :json
        data = JSON.parse(response.body)

        expect(response.status).to eq 404
        expect(data["errors"]).to include "Record not found"
      end
    end
  end
end

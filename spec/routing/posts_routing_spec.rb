require "rails_helper"

RSpec.describe PostsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/posts/1").to route_to("posts#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/posts").to route_to("posts#create")
    end
  end
end

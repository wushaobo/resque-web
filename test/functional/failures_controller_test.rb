require 'test_helper'

module ResqueWeb
  class FailuresControllerTest < ActionController::TestCase
    include ControllerTestHelpers

    setup do
      @routes = Engine.routes
    end

    describe "GET /failures" do
      it "renders the index page" do
        visit(:index)
        assert_template :index
      end
    end
  end
end

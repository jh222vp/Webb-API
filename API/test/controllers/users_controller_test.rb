require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  
  test "GET /users should list all users" do
    assert_routing '/users',{controller: "users", action: "index"}
    get :index
  end
end

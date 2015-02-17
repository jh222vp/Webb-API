require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  
  test "Name length validation" do
    t = User.new
    t.name = "Jonas"*1
    t.password = "testPassword"
    t.key = "testKey"
    assert t.save
  end
  
  test "password length validation" do
    t = User.new
    t.name = "Jonas"
    t.password = "a"*10
    t.key = "testKey"
    assert t.save
  end
  
  test "Should save with everything name" do
    t = User.new
    t.name = "Jonas"
    t.password = "testPassword"
    t.key = "testKey"
    assert t.save
  end
  
  test "Should not save without name" do
    t = User.new
    t.password = "testPassword"
    t.key = "testKey"
    assert_not t.save
  end
  
  
   def setup
     @user = User.new(name: "Jonas", password: "foobar", password_confirmation: "foobar")
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end

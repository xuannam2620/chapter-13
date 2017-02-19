require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users :tranxuannam
    @admin = users :admin
  end

  test "index including pagination" do
    log_in_as @user
    get users_path
    assert_template "users/index", count: 1
    assert_select "div.pagination"
    User.paginate(page: 1).each do |user|
      assert_select "a[href=?]",user_path(user), text: user.name
    end
  end

  test "index as admin including pagination and delete links" do
    log_in_as @admin
    get users_path
    assert_template "users/index", count: 1
    assert_select "div.pagination"
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
      unless user == @admin
        assert_select "a[href=?]", user_path(user), text: "Delete"
      end
    end
    assert_difference "User.count", -1 do
      delete user_path(@user)
    end
  end

  test "index as non-admin" do
    log_in_as @user
    get users_path
    assert_select "a", text: "Delete", count: 0
  end
end

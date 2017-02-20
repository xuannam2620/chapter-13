require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users :admin
  end

  test "profile display" do
    get user_path @user
    assert_template "users/show", count: 1
    assert_select "h1", text: @user.name
    assert_select "h1>img.gavatar"
    assert_match @user.microposts.count.to_s, response.body
    assert_select "div.pagination"
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end
end

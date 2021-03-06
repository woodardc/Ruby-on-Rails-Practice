require 'test_helper'

  def setup
     @user = User.create(username: "joey", email: "joeys@world.com", password: "password", admin:true)
  end

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  test "get new category form and create category" do
    sign_in_as(@user.username, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: "turtles"}
    end
    assert_template 'categories/index'
    assert_match "turtles", response.body
  end
  
  test "invalid category submission results in failure" do
    sign_in_as(@user.username, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, category: {name: " "}
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
    
  end
  
end
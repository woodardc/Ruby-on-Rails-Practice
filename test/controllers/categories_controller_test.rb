require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  
  def setup
     @category = Category.new(id: 0, name: "turtles")  
     @user = User.create(username: "joey", email: "joeys@world.com", password: "password", admin:true)
  end
  
  test "shouldl get categories index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end
  
  test "should get show" do
    get(:show, {'id' => @category.id})
    assert_response :success
  end
  
  test "should redirect page from create when user is not an administrator" do
    assert_no_difference 'Category.count' do
      post :create, category: {name: "turtles"}
    end
    assert_redirect_to categories_path
  end
end
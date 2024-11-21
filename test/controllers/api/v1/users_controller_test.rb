require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end
  test "should show user" do
    get api_v1_user_url(@user), as: :json
    assert_response :success
    json_response = JSON.parse(self.response.body)
    assert_equal @user.email, json_response['email']
  end

  test "should create user" do
    assert_difference('User.count') do
      post api_v1_users_url, params: { user: { email: 'test@test.org', password: '123456' } }, as: :json
    end
    assert_response :created 
    # by means we are using the status code of 201
  end

  test "should not create user with taken email" do
    assert_no_difference('User.count') do
      post api_v1_users_url, params: { user: { email: @user.email, password: '123456' } }, as: :json
    end
    assert_response :unprocessable_entity
    # by means we are using the status code of 422
  end

  test "should update user" do
    patch api_v1_users_url(@user), params: { user: { email: @user.email,password: '123456' } }, as: :json
    assert_response :success
  end

  test "should not update user when invalid params are sent" do
    patch api_v1_user_url(@user), params: { user: { email: 'bad_email', password: '123456' } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should delete user" do
    assert_difference('User.count', -1) do
      delete api_v1_user_url(@user), as: :json
    end
    assert_response :no_content
    # by means status code is 204 we can return the 200 also
  end

end

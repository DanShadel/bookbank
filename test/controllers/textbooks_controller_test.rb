require 'test_helper'

class TextbooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @textbook = textbooks(:one)
  end

  test "should get index" do
    get textbooks_url
    assert_response :success
  end

  test "should get new" do
    get new_textbook_url
    assert_response :success
  end

  test "should create textbook" do
    assert_difference('Textbook.count') do
      post textbooks_url, params: { textbook: { condition: @textbook.condition, isbn: @textbook.isbn, title: @textbook.title } }
    end

    assert_redirected_to textbook_url(Textbook.last)
  end

  test "should show textbook" do
    get textbook_url(@textbook)
    assert_response :success
  end

  test "should get edit" do
    get edit_textbook_url(@textbook)
    assert_response :success
  end

  test "should update textbook" do
    patch textbook_url(@textbook), params: { textbook: { condition: @textbook.condition, isbn: @textbook.isbn, title: @textbook.title } }
    assert_redirected_to textbook_url(@textbook)
  end

  test "should destroy textbook" do
    assert_difference('Textbook.count', -1) do
      delete textbook_url(@textbook)
    end

    assert_redirected_to textbooks_url
  end
end

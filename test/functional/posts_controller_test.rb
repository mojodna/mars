require File.dirname(__FILE__) + '/../test_helper'
require 'posts_controller'

# Re-raise errors caught by the controller.
class PostsController; def rescue_action(e) raise e end; end

class PostsControllerTest < Test::Unit::TestCase
  fixtures :posts

  def setup
    @controller = PostsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:posts)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_post
    old_count = Post.count
    post :create, :post => { }
    assert_equal old_count+1, Post.count
    
    assert_redirected_to post_path(assigns(:post))
  end

  def test_should_show_post
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_post
    put :update, :id => 1, :post => { }
    assert_redirected_to post_path(assigns(:post))
  end
  
  def test_should_destroy_post
    old_count = Post.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Post.count
    
    assert_redirected_to posts_path
  end
end

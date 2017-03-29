require 'test_helper'
# module SafetyConeMountable
  class SafetyConeMountable::ConesControllerTest < ActionController::TestCase

    test "get root page of mountable_engine" do
       get :mountable_engine
       get :index
       assert_response :success
     end
  end
# end

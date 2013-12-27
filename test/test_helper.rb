ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'


class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Add more helper methods to be used by all tests here...
  #def self.should_not_respond_to_actions(actions = {})
  #  actions.each do |name, method|
  #    test "should not respond to #{method.to_s.upcase} :#{name}" do
  #      assert_raise ActionController::UrlGenerationError do
  #        send(method, name)
  #      end
  #    end
  #  end
  #end

  #def testing_class
  #  begin
  #    self.class.to_s[0..-5].constantize
  #  rescue NameError
  #    nil
  #  end
  #end
end

ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/rails/capybara'

Capybara.javascript_driver = :webkit

# To add Capybara feature tests add `gem 'minitest-rails-capybara'`
# to the test group in the Gemfile and uncomment the following:
# require 'minitest/rails/capybara'

# Uncomment for awesome colorful output
require 'minitest/pride'
require 'mocha/setup'

class ActiveSupport::TestCase
  include Warden::Test::Helpers

  ActiveRecord::Migration.check_pending!
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  fixtures :all

  def setup
    #Device test helpers don't work in combination with minitest
    Warden.test_reset!
    setup_warden
  end

  def request
    @request ||= ActionController::TestRequest.new
  end

  def setup_warden
    @warden ||= begin
      manager = Warden::Manager.new(nil,
        &Rails.application.config.middleware.detect{|m| m.name == 'Warden::Manager'}.block)
        request.env['warden'] = Warden::Proxy.new(@request.env, manager)
     end
  end

  alias_method :warden, :setup_warden

  # Copied from devise gem
  def sign_in(resource_or_scope, resource=nil)
    scope    ||= Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    warden.instance_variable_get(:@users).delete(scope)
    warden.session_serializer.store(resource, scope)
  end

  def sign_out(resource_or_scope)
    return if resource_or_scope.nil?
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    @controller.instance_variable_set(:"@current_#{scope}", nil)
    user = warden.instance_variable_get(:@users).delete(scope)
    warden.session_serializer.delete(scope, user)
  end

  def sign_in_as_user
    @_current_user = User.create(:email => 'frank@fablab.nl', :password => 'dovadi2014', :password_confirmation => 'dovadi2014' )
    sign_in @_current_user
  end

  def sign_out_as_user
    sign_out @_current_user
  end

end

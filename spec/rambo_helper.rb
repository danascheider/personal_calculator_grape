require "spec_helper"
require "rack/test"
require_relative "./support/matchers/rambo_matchers"

module ApiHelper
  include Rack::Test::Methods

  def app
    PersonalCalculator::API
  end
end

RSpec.configure do |config|
  config.include ApiHelper, type: :rambo
end
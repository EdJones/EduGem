require 'test_helper'

class AssessmentTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Assessment.new.valid?
  end
end

require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "should not consider project valid without name" do
    project = Project.new(name: nil)

    assert_not project.valid?
  end
end

require "test_helper"

class ProjectStakeholderTest < ActiveSupport::TestCase
  setup do
    @project_stakeholder = project_stakeholders(:one)
    @account = accounts(:account_with_no_records)
    @project = projects(:one)

    @project_stakeholder_params = {
      account_id: @account.id,
      project_id: @project.id
    }
  end

  # Associations
  test "should test all project_stakeholder associations" do
    %i[account project].each do |association|
      assert_association @project_stakeholder, association
    end
  end

  # Validations
  test "should validate the @project_stakeholder_params" do
    project_stakeholder = ProjectStakeholder.new @project_stakeholder_params

    assert project_stakeholder.valid?
  end

  test "should check presence of account_id" do
    project_stakeholder = ProjectStakeholder.new @project_stakeholder_params.merge(account_id: nil)

    assert_not project_stakeholder.valid?
  end

  test "should check presence of project_id" do
    project_stakeholder = ProjectStakeholder.new @project_stakeholder_params.merge(project_id: nil)

    assert_not project_stakeholder.valid?
  end

  test "should check uniqueness of account_id in scope of project_id" do
    account = accounts(:one) # Is already a project stakeholder of @project

    project_stakeholder = ProjectStakeholder.new @project_stakeholder_params.merge(account_id: account.id)

    assert_not project_stakeholder.valid?
  end
end

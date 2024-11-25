require "test_helper"

class ProjectCollaboratorTest < ActiveSupport::TestCase
  setup do
    @project_collaborator = project_collaborators(:one)
    @account = accounts(:account_with_no_records)
    @project = projects(:one)

    @project_collaborator_params = {
      account_id: @account.id,
      project_id: @project.id
    }
  end

  # Validations
  test "should validate the @project_collaborator_params" do
    project_collaborator = ProjectCollaborator.new @project_collaborator_params

    assert project_collaborator.valid?
  end

  test "should check presence of account_id" do
    project_collaborator = ProjectCollaborator.new @project_collaborator_params.merge(account_id: nil)

    assert_not project_collaborator.valid?
  end

  test "should check presence of project_id" do
    project_collaborator = ProjectCollaborator.new @project_collaborator_params.merge(project_id: nil)

    assert_not project_collaborator.valid?
  end

  test "should check uniqueness of account_id in scope of project_id" do
    account = accounts(:one) # Is already a project collaborator of @project

    project_collaborator = ProjectCollaborator.new @project_collaborator_params.merge(account_id: account.id)

    assert_not project_collaborator.valid?
  end

  test "should check the validity of role" do
    assert_raises(ArgumentError) do
      project_collaborator = ProjectCollaborator.new @project_collaborator_params.merge(role: :unknown)
    end
  end
end

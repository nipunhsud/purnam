require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  setup do
    @project = projects(:one)
    @project_params = {
      name: Faker::Lorem.word,
      description: Faker::Lorem.paragraphs.join,
      start_date: 10.days.ago,
      end_date: 50.days.from_now
    }
  end

  # Associations
  test "should check all associations of project" do
    %i[project_collaborators collaborators project_stakeholders stakeholders].each do |association|
      assert_association @project, association
    end
  end

  # Validations
  test "should check if @project_params are valid" do
    project = Project.new @project_params

    assert project.valid?
  end

  test "should not consider project valid without name" do
    project = Project.new @project_params.merge(name: nil)

    assert_not project.valid?
  end

  test "should not consider project valid without description" do
    project = Project.new @project_params.merge(description: nil)

    assert_not project.valid?
  end

  test "should not consider project valid without start_date" do
    project = Project.new @project_params.merge(start_date: nil)

    assert_not project.valid?
  end

  test "should not consider project valid with end_date" do
    project = Project.new @project_params.merge(end_date: nil)

    assert_not project.valid?
  end

  test "should not consider project with end_date before start_date as valid" do
    project = Project.new @project_params.merge(end_date: 20.days.ago)

    assert_not project.valid?
  end

  # Callbacks
  test "should create a project_collaborator and project_stakeholder for owner if owner_account is present" do
    account = accounts(:account_with_no_records)

    assert_difference -> { ProjectCollaborator.count } => 1, -> { ProjectStakeholder.count } => 1 do
      Project.create @project_params.merge(owner_account: account)
    end
  end

  test "should delete project_collaborator associations if the respective project is deleted" do
    assert_difference("ProjectCollaborator.count", -@project.project_collaborators.count) { @project.destroy }
  end

  test "should delete project_stakeholder associations if the respective project is deleted" do
    assert_difference("ProjectStakeholder.count", -@project.project_stakeholders.count) { @project.destroy }
  end
end

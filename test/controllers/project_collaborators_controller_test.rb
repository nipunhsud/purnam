require "test_helper"

class ProjectCollaboratorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    authenticate_user(:one)

    @account = accounts(:account_with_no_records)
    @project_collaborator = project_collaborators(:one)
    @project = @project_collaborator.project

    @project_collaborator_params = { account_id: @account.id }
  end

  test "should get new" do
    get new_project_project_collaborator_url(@project), as: :turbo_stream
    assert_response :success
  end

  test "should create project_collaborator" do
    assert_difference("ProjectCollaborator.count") do
      post project_project_collaborators_url(@project), params: { project_collaborator: @project_collaborator_params }, as: :turbo_stream
    end
  end

  test "should render if project_collaborator creation fails" do
    post project_project_collaborators_url(@project), params: { project_collaborator: @project_collaborator_params.merge(account_id: nil) }, as: :turbo_stream

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_project_project_collaborator_url(@project, @project_collaborator), as: :turbo_stream
    assert_response :success
  end

  test "should update project_collaborator" do
    patch project_project_collaborator_url(@project, @project_collaborator), params: { project_collaborator: @project_collaborator_params }, as: :turbo_stream

    assert_response :success
  end

  test "should render unprocessable_entity if update fails" do
    patch project_project_collaborator_url(@project, @project_collaborator), params: { project_collaborator: @project_collaborator_params.merge(account_id: nil) }, as: :turbo_stream

    assert_response :unprocessable_entity
  end

  test "should destroy project_collaborator" do
    assert_difference("ProjectCollaborator.count", -1) do
      delete project_project_collaborator_url(@project, @project_collaborator), as: :turbo_stream
    end
  end
end

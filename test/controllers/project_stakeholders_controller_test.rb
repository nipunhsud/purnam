require "test_helper"

class ProjectStakeholdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    authenticate_user(:one)

    @account = accounts(:account_with_no_records)
    @project_stakeholder = project_stakeholders(:one)
    @project = @project_stakeholder.project

    @project_stakeholder_params = { account_id: @account.id }
  end

  test "should get new" do
    get new_project_project_stakeholder_url(@project), as: :turbo_stream
    assert_response :success
  end

  test "should create project_stakeholder" do
    assert_difference("ProjectStakeholder.count") do
      post project_project_stakeholders_url(@project), params: { project_stakeholder: @project_stakeholder_params }, as: :turbo_stream
    end
  end

  test "should render if project_stakeholder creation fails" do
    post project_project_stakeholders_url(@project), params: { project_stakeholder: @project_stakeholder_params.merge(account_id: nil) }, as: :turbo_stream

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_project_project_stakeholder_url(@project, @project_stakeholder), as: :turbo_stream
    assert_response :success
  end

  test "should update project_stakeholder" do
    patch project_project_stakeholder_url(@project, @project_stakeholder), params: { project_stakeholder: @project_stakeholder_params }, as: :turbo_stream

    assert_response :success
  end

  test "should render unprocessable_entity if update fails" do
    patch project_project_stakeholder_url(@project, @project_stakeholder), params: { project_stakeholder: @project_stakeholder_params.merge(account_id: nil) }, as: :turbo_stream

    assert_response :unprocessable_entity
  end

  test "should destroy project_stakeholder" do
    assert_difference("ProjectStakeholder.count", -1) do
      delete project_project_stakeholder_url(@project, @project_stakeholder), as: :turbo_stream
    end
  end
end

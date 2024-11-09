require "test_helper"

class ProjectStakeholdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project_stakeholder = project_stakeholders(:one)
  end

  test "should get index" do
    get project_stakeholders_url
    assert_response :success
  end

  test "should get new" do
    get new_project_stakeholder_url
    assert_response :success
  end

  test "should create project_stakeholder" do
    assert_difference("ProjectStakeholder.count") do
      post project_stakeholders_url, params: { project_stakeholder: { account_id: @project_stakeholder.account_id, project_id: @project_stakeholder.project_id } }
    end

    assert_redirected_to project_stakeholder_url(ProjectStakeholder.last)
  end

  test "should show project_stakeholder" do
    get project_stakeholder_url(@project_stakeholder)
    assert_response :success
  end

  test "should get edit" do
    get edit_project_stakeholder_url(@project_stakeholder)
    assert_response :success
  end

  test "should update project_stakeholder" do
    patch project_stakeholder_url(@project_stakeholder), params: { project_stakeholder: { account_id: @project_stakeholder.account_id, project_id: @project_stakeholder.project_id } }
    assert_redirected_to project_stakeholder_url(@project_stakeholder)
  end

  test "should destroy project_stakeholder" do
    assert_difference("ProjectStakeholder.count", -1) do
      delete project_stakeholder_url(@project_stakeholder)
    end

    assert_redirected_to project_stakeholders_url
  end
end

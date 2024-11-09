require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    authenticate_user(:one)

    @project = projects(:one)
    @project_params = {
      name: Faker::Lorem.word,
      description: Faker::Lorem.sentence,
      start_date: 10.days.ago,
      end_date: 10.days.from_now
    }
  end

  test "should get index" do
    get projects_url
    assert_response :success
  end

  test "should get new" do
    get new_project_url, as: :turbo_stream
    assert_response :success
  end

  test "should create project" do
    assert_difference("Project.count") do
      post projects_url, params: { project: @project_params }, as: :turbo_stream
    end

    assert_response :success
  end

  test "should render error if project creation fails" do
    post projects_url, params: { project: @project_params.merge(name: nil) }, as: :turbo_stream

    assert_response :unprocessable_entity
  end

  test "should show project" do
    get project_url(@project)
    assert_response :success
  end

  test "should get edit" do
    get edit_project_url(@project), as: :turbo_stream

    assert_response :success
  end

  test "should update project" do
    patch project_url(@project), params: { project: { name: "Other Name" } }, as: :turbo_stream

    assert @project.reload.name == "Other Name"
    assert_redirected_to projects_url
  end

  test "should render error if project update fails" do
    patch project_url(@project), params: { project: { name: nil } }, as: :turbo_stream
    assert_response :unprocessable_entity
  end

  test "should destroy project" do
    assert_difference("Project.count", -1) do
      delete project_url(@project), as: :turbo_stream
    end

    assert_redirected_to projects_url
  end
end

# require "test_helper"

# class ProjectCollaboratorsControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     @project_collaborator = project_collaborators(:one)
#     authenticate_user(:one)
#   end

#   test "should get index" do
#     get project_collaborators_url
#     assert_response :success
#   end

#   test "should get new" do
#     get new_project_collaborator_url
#     assert_response :success
#   end

#   test "should create project_collaborator" do
#     assert_difference("ProjectCollaborator.count") do
#       post project_collaborators_url, params: { project_collaborator: { account_id: @project_collaborator.account_id, project_id: @project_collaborator.project_id, role: @project_collaborator.role } }
#     end

#     assert_redirected_to project_collaborator_url(ProjectCollaborator.last)
#   end

#   test "should show project_collaborator" do
#     get project_collaborator_url(@project_collaborator)
#     assert_response :success
#   end

#   test "should get edit" do
#     get edit_project_collaborator_url(@project_collaborator)
#     assert_response :success
#   end

#   test "should update project_collaborator" do
#     patch project_collaborator_url(@project_collaborator), params: { project_collaborator: { account_id: @project_collaborator.account_id, project_id: @project_collaborator.project_id, role: @project_collaborator.role } }
#     assert_redirected_to project_collaborator_url(@project_collaborator)
#   end

#   test "should destroy project_collaborator" do
#     assert_difference("ProjectCollaborator.count", -1) do
#       delete project_collaborator_url(@project_collaborator)
#     end

#     assert_redirected_to project_collaborators_url
#   end
# end

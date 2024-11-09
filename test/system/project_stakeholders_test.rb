require "application_system_test_case"

class ProjectStakeholdersTest < ApplicationSystemTestCase
  setup do
    @project_stakeholder = project_stakeholders(:one)
  end

  test "visiting the index" do
    visit project_stakeholders_url
    assert_selector "h1", text: "Project stakeholders"
  end

  test "should create project stakeholder" do
    visit project_stakeholders_url
    click_on "New project stakeholder"

    fill_in "Account", with: @project_stakeholder.account_id
    fill_in "Project", with: @project_stakeholder.project_id
    click_on "Create Project stakeholder"

    assert_text "Project stakeholder was successfully created"
    click_on "Back"
  end

  test "should update Project stakeholder" do
    visit project_stakeholder_url(@project_stakeholder)
    click_on "Edit this project stakeholder", match: :first

    fill_in "Account", with: @project_stakeholder.account_id
    fill_in "Project", with: @project_stakeholder.project_id
    click_on "Update Project stakeholder"

    assert_text "Project stakeholder was successfully updated"
    click_on "Back"
  end

  test "should destroy Project stakeholder" do
    visit project_stakeholder_url(@project_stakeholder)
    click_on "Destroy this project stakeholder", match: :first

    assert_text "Project stakeholder was successfully destroyed"
  end
end

require "application_system_test_case"

class ProjectsTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit projects_url
  #
  #   assert_selector "h1", text: "Project"
  # end

  setup do
    @project = projects(:first) # Reference to the first fixture project
  end

  test "Creating a new project" do
    # When we visit the Quotes#index page
    # we expect to see a title with the text "Quotes"
    visit projects_path
    assert_selector "h1", text: "Projects"

    # When we click on the link with the text "New quote"
    # we expect to land on a page with the title "New quote"
    click_on "New project"
    assert_selector "h1", text: "New project"

    # When we fill in the name input with "Capybara quote"
    # and we click on "Create Quote"
    fill_in "Name", with: "Capybara project"
    click_on "Create project"

    # We expect to be back on the page with the title "Quotes"
    # and to see our "Capybara quote" added to the list
    assert_selector "h1", text: "Projects"
    assert_text "Capybara project"
  end

  test "Showing a project" do
    visit projects_path
    click_link @project.name

    assert_selector "h1", text: @project.name
  end

  test "Updating a project" do
    visit projects_path
    assert_selector "h1", text: "Projects"

    click_on "Edit", match: :first
    assert_selector "h1", text: "Edit project"

    fill_in "Name", with: "Updated project"
    click_on "Update project"

    assert_selector "h1", text: "Projects"
    assert_text "Updated project"
  end

  test "Destroying a project" do
    visit projects_path
    assert_text @project.name

    click_on "Delete", match: :first
    assert_no_text @project.name
  end

end

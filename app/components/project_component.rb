class ProjectComponent < ViewComponent::Base
  include Colors::ProjectColorsHelper

  delegate :component, to: :helpers

  def initialize(project:)
    @project = project
    @role = ProjectCollaborator.roles.key(@project.role).to_sym

    prepare_colors
  end
end

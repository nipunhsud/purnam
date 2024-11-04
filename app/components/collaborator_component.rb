class CollaboratorComponent < ViewComponent::Base
  include Colors::ProjectColorsHelper

  def initialize(collaborator:)
    @collaborator = collaborator
    @role = ProjectCollaborator.roles.key(@collaborator.role).to_sym

    prepare_colors
  end
end

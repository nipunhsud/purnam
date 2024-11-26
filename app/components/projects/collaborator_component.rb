module Projects
  class CollaboratorComponent < ViewComponent::Base
    include Colors::ProjectColorsHelper

    def initialize(collaborator:)
      @collaborator = collaborator
      @role = @collaborator.role

      prepare_colors
    end
  end
end

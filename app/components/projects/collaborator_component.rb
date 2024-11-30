module Projects
  class CollaboratorComponent < ApplicationComponent
    include Colors::ProjectColorsHelper

    def initialize(collaborator:)
      @collaborator = collaborator
      @role = @collaborator.role

      prepare_colors
    end
  end
end

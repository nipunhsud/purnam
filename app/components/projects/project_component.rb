module Projects
  class ProjectComponent < ViewComponent::Base
    delegate :component, to: :helpers

    def initialize(project:)
      @project = project
    end
  end
end

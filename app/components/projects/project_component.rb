module Projects
  class ProjectComponent < ApplicationComponent
    delegate :component, to: :helpers

    def initialize(project:)
      @project = project
    end
  end
end

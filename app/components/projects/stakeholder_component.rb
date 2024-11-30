module Projects
  class StakeholderComponent < ApplicationComponent
    def initialize(stakeholder:)
      @stakeholder = stakeholder
    end
  end
end

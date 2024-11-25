module Projects
  class StakeholderComponent < ViewComponent::Base
    def initialize(stakeholder:)
      @stakeholder = stakeholder
    end
  end
end

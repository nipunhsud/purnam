module Shared
  class PasswordToggleButtonComponent < ApplicationComponent
    renders_one :icon_block

    def initialize(target:)
      @target = target
    end
  end
end

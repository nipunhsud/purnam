module Shared
  class SidebarComponent < ViewComponent::Base
    delegate :authenticated?, :unauthenticated?, :icon_svg, to: :helpers
  end
end

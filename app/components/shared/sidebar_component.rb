module Shared
  class SidebarComponent < ApplicationComponent
    delegate :authenticated?, :unauthenticated?, :icon_svg, to: :helpers
  end
end

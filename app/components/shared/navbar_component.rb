module Shared
  class NavbarComponent < ApplicationComponent
    delegate :authenticated?, :unauthenticated?, to: :helpers
  end
end

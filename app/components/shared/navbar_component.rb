module Shared
  class NavbarComponent < ViewComponent::Base
    delegate :authenticated?, :unauthenticated?, to: :helpers
  end
end

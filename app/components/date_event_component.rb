class DateEventComponent < ViewComponent::Base
  include Colors::DateEventColorsHelper

  def initialize(date:, color:)
    @date = date

    @bg_color = COLORS.dig(color, :bg)
    @text_color = COLORS.dig(color, :text)
  end
end

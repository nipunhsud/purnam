class DateEventComponent < ViewComponent::Base
  COLORS = {
    primary: { border: "border-primary-500", bg: "bg-primary-500", text: "text-primary-500" },
    emerald: { border: "border-emerald-500", bg: "bg-emerald-500", text: "text-emerald-500" },
    rose: { border: "border-rose-500", bg: "bg-rose-500", text: "text-rose-500" }
  }.with_indifferent_access

  def initialize(date:, color:)
    @date = date

    @bg_color = COLORS.dig(color, :bg)
    @text_color = COLORS.dig(color, :text)
  end
end

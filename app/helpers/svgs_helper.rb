module SvgsHelper
  AVAILABLE_VARIANTS = %i[regular thin light bold fill duotone].freeze
  ICONS_PATH = "app/assets/images/icons"
  ICONS = Dir.entries(ICONS_PATH).excluding(".", "..").freeze

  def icon_svg(icon, extension: "svg", variant: nil, **opts)
    variant = variant.to_sym if variant.present?
    raise ArgumentError.new("Variant not present. Available variants: #{AVAILABLE_VARIANTS}") if variant.present? && !variant.in?(AVAILABLE_VARIANTS)

    icon_name = icon.to_s
    icon_name = "#{icon_name}_#{variant}" if variant.present?

    svg = File.read Rails.root.join("#{ICONS_PATH}/#{icon_name}.#{extension}")
    svg = Nokogiri::XML(svg).children.first

    opts.each { |key, value| svg[key] = value } if opts.present?

    raw svg.to_xml
  end
end

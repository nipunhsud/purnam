module SvgsHelper
  ICONS_PATH = "app/assets/images/icons/"
  ICONS = Dir.entries(ICONS_PATH).excluding(".", "..").freeze

  def icon_svg(icon, extension: "svg", **opts)
    icon_name = icon.to_s

    svg = File.read Rails.root.join("#{ICONS_PATH}#{icon_name}.#{extension}")
    svg = Nokogiri::XML(svg).children.first

    opts.each { |key, value| svg[key] = value } if opts.present?

    raw svg.to_xml
  end
end

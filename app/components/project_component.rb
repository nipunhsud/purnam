class ProjectComponent < ViewComponent::Base
  delegate :component, to: :helpers

  ROLE_COLORS_HASH = {
    emerald: { text: "text-emerald-600", bg: "bg-emerald-50", border: "border-emerald-500", hover: "hover:bg-emerald-50" },
    orange: { text: "text-orange-600", bg: "bg-orange-50", border: "border-orange-500", hover: "hover:bg-orange-50" },
    primary: { text: "text-primary-600", bg: "bg-primary-50", border: "border-primary-500", hover: "hover:bg-primary-50" }
  }.with_indifferent_access

  ROLE_COLOR_MAP = {
    owner: :emerald,
    admin: :orange,
    user: :primary
}.with_indifferent_access

  def initialize(project:)
    @project = project
    @role = ProjectCollaborator.roles.key(@project.role).to_sym

    prepare_colors
  end

  private
    def prepare_colors
      %i[text bg border hover].each do |property|
        @role_color = ROLE_COLOR_MAP[@role]
        instance_variable_set "@#{property}_color", ROLE_COLORS_HASH.dig(@role_color, property)
      end
    end
end

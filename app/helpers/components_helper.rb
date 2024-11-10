module ComponentsHelper
  def component(component_class, ...)
    render component_class.new(...)
  end

  def components(component_class, ...)
    render component_class.with_collection(...)
  end
end

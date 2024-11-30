module ComponentsHelper
  def component(component_class, **kwargs, &block)
    render(component_class.new(**kwargs), &block)
  end

  def components(component_class, ...)
    render component_class.with_collection(...)
  end
end

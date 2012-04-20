# The ElementBuilder by default renders the link within a <li> element. 
# An element can be passed to render the link within that element, for example rendering
# in a <div> element.
#
# The ElementBuilder accepts a limited set of options.
# If you need more flexibility, create a custom Builder and
# pass the option :builder => BuilderClass to the <tt>render_breadcrumbs</tt> helper method.

# [!] You have to put this in your environment :
#     require 'breadcrumbs_on_rails/breadcrumbs/element_builder'
#
# Then configure your renderer, like this :
#     <%= render_breadcrumbs(
#           :builder => BreadcrumbsOnRails::Breadcrumbs::ElementBuilder,
#         ).html_safe %>
#
# To render the <a> element in another element, pass the element:
#
#     <%= render_breadcrumbs(
#           :builder => BreadcrumbsOnRails::Breadcrumbs::ElementBuilder, :element => :div
#         ).html_safe %>
#
# This would render <div><a href="/">Title</a></div>s
module BreadcrumbsOnRails
  module Breadcrumbs
    class ElementBuilder < Builder
      def render
        @elements.collect do |element|
          render_element(element)
        end.join(@options[:separator] || " &raquo; ")
      end

			def render_element(element)
        url = (compute_path(element).present? ? compute_path(element) : '#')
        content = @context.link_to(compute_name(element), url)
        @context.content_tag(@options[:element] || :li, content)
      end

    end
  end
end
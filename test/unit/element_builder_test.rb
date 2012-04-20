require 'test_helper'
require 'breadcrumbs_on_rails/breadcrumbs/element_builder'

class ElementBuilderTest < ActionView::TestCase

  def setup
    @template = self
  end


  def test_render_should_be_implemented
    assert_nothing_raised { element_builder(@template, []).render }
  end


  def test_render_with_0_elements
    assert_equal("", element_builder(@template, []).render)
  end

  def test_render_with_0_elements_and_separator
    assert_equal("", element_builder(@template, [], :separator => "-").render)
  end


  def test_render_with_1_element
    @template.expects(:current_page?).times(1).returns(false)
    assert_dom_equal("<li><a href=\"/element/1\">Element 1</a></li>",
                     element_builder(@template, generate_elements(1)).render)
  end

  def test_render_with_1_element_and_separator
    @template.expects(:current_page?).times(1).returns(false)
    assert_dom_equal("<li><a href=\"/element/1\">Element 1</a></li>",
                     element_builder(@template, generate_elements(1), :separator => "-").render)
  end


  def test_render
    @template.expects(:current_page?).times(2).returns(false)
    assert_dom_equal("<li><a href=\"/element/1\">Element 1</a></li> &raquo; <li><a href=\"/element/2\">Element 2</a></li>",
                     element_builder(@template, generate_elements(2)).render)
  end

  def test_render_with_separator
    @template.expects(:current_page?).times(2).returns(false)
    assert_dom_equal("<li><a href=\"/element/1\">Element 1</a></li> - <li><a href=\"/element/2\">Element 2</a></li>",
                     element_builder(@template, generate_elements(2), :separator => " - ").render)
  end

  def test_render_with_current_page
    @template.expects(:current_page?).times(2).returns(false, true)
    assert_dom_equal("<li><a href=\"/element/1\">Element 1</a></li> &raquo; <li>Element 2</li>",
                     element_builder(@template, generate_elements(2)).render)
  end


  protected

  def element_builder(*args)
    BreadcrumbsOnRails::Breadcrumbs::ElementBuilder.new(*args)
  end

  def generate_elements(number)
    (1..number).collect do |index|
      BreadcrumbsOnRails::Breadcrumbs::Element.new("Element #{index}", "/element/#{index}")
    end
  end

end

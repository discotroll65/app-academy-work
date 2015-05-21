require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/core_ext'
require 'erb'
require 'pry-byebug'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      template = File.read(
        "./views/#{self.class.to_s.underscore}/#{template_name}.html.erb"
      )
      content = ERB.new( template ).result(binding)
      render_content(content, "text/html")
    end

    def link_to(link_name, url_path)
      "<a href=#{url_path}>#{link_name}</a>"
    end

    def button_to(button_msg, button_path, button_method = {method: "post"})
      html=<<-HTML
        <form action="#{button_path}" method="post">
          <input type="hidden" name="_method" value="#{button_method[:method]}">
          <input type="submit" value="#{button_msg}">
        </form>
      HTML
    end
  end
end

module ApplicationHelper
def markdown(text)
    options = {
            space_after_headers: true, 
          }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
end

 def title(page_title)
    content_for(:title) { page_title }
  end
end

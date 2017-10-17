require 'haml'
require 'tilt'
require 'fileutils'

module Rendering
  def current_dir
    File.dirname(__FILE__)
  end

  def partial(filename, locals = {:locals => ""})
    render_haml(File.read("#{current_dir}/../partials/_#{filename}.haml"), locals)
  end

  def render_with_layout(file_path, layout = "mail")
    $layout = layout

    template = read_layout(layout)
    content = set_content(file_path, template)

    #make new dir
    FileUtils.mkdir_p(new_path(file_path, layout))

    #create new file and save content
    write_to_file(file_path, layout, content)
  end

  private
  def render_haml(contents, locals = {:locals => ""})
    Haml::Engine.new(contents).render(Object.new, locals)
  end

  def read_layout(layout)
    tpl = "#{current_dir}/../layouts/#{layout}.html.haml"
    Tilt::HamlTemplate.new(tpl)
  end

  def set_content(file_path, template)
    content = File.read(file_path)
    template.render {render_haml(content)}
  end

  def file_name(file_path)
    File.basename(file_path).gsub File.extname(file_path), ""
  end

  def new_path(file_path, layout)
    File.join(File.dirname(file_path), "/#{layout}/")
  end

  def write_to_file(file_path, layout, content)
    new_file_url = File.join(new_path(file_path, layout), file_name(file_path))
    f = File.new("#{new_file_url}.html", "w+")
    f.write(content)
    f.close
  end
end

include Rendering

require_relative "src/helpers/rendering"

#create HTML versions of HAML templates
files_to_render = Dir.glob("src/**/*.haml").delete_if {|file| file =~ /layouts|partials/}
files_to_render.each do |file|
  render_with_layout("#{file}", 'web')
  render_with_layout("#{file}", 'mail')
end
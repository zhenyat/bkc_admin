#!/usr/bin/env ruby
################################################################################
#   bin/bkc
#     Generates Admin Controller for the given Model
#
#   25.01.2015  ZT
#   23.02.2015  v 1.0.0
#   04.03.2015  v 1.1.0
#   05.03.2015  v 1.2.0   activate admin module and layout
################################################################################
# admin directory
relative_path = 'app/controllers/admin'
admin_path    = "#{$app_root}/#{relative_path}"

action_report relative_path
Dir.mkdir(admin_path) unless File.exist?(admin_path)

# Controller file
relative_path = "app/controllers/admin/#{$names}_controller.rb"
absolute_path = "#{$app_root}/#{relative_path}"
action_report relative_path

file = File.open(absolute_path, 'w')

# Generate controller code
file.puts "class Admin::#{$models}Controller < ApplicationController"
file.puts "\tinclude AdminAccess\n\tlayout 'admin'\n\n"
file.puts "\tbefore_filter :check_login"
file.puts "\tbefore_action :set_#{$name}, only: [:show, :edit, :update,:destroy]"

file.puts "\n\tdef create\n\t\tbuild_#{$name}\n\t\tsave_#{$name} or render 'new'\n\tend"

file.puts "\n\tdef destroy\n\t\tload_#{$name}\n\t\t@#{$name}.destroy\n\t\tredirect_to admin_#{$names}_url, notice: '#{$model} was successfully destroyed'\n\tend"

file.puts "\n\tdef edit\n\t\tload_#{$name}\n\t\tbuild_#{$name}\n\tend"

file.puts "\n\tdef index\n\t\tload_#{$names}\n\tend"

file.puts "\n\tdef new\n\t\tbuild_#{$name}\n\tend"

file.puts "\n\tdef show\n\t\tload_#{$name}\n\tend"

file.puts "\n\tdef update\n\t\tload_#{$name}\n\t\tbuild_#{$name}\n\t\tupdate_#{$name} or render 'edit'\n\tend"

file.puts "\n\tprivate\n"

file.puts "\n\t# #{$model} white list attributes"
line = "\tdef #{$name}_params\n\t\t#{$name}_params = params[:#{$name}]\n\t\t#{$name}_params ? #{$name}_params.permit("
$attr_names.each do |attr_name|
  if $references_names.include? attr_name
    line << ":#{attr_name}_id"                        # FK attribute
  else
    line << ":#{attr_name}"                           # Ordinary attribute
  end
  line << ", " unless attr_name== $attr_names.last    # Non-last attribute
end
line << ") : {}\n\tend"
file.puts line

file.puts "\n\tdef #{$name}_scope\n\t\t#{$model}.all\n\tend\n"

# FK scopes
unless $references_names.empty?
  $attr_names.each do |attr_name|
    if $references_names.include? attr_name
      if attr_name.include? "_"             # Compound model name e.g. building_type
        words = attr_name.split "_"
        compound_model_name = ""
        words.each do |word|
          compound_model_name << word.capitalize
        end
        file.puts "\n\tdef #{attr_name}_scope\n\t\t#{compound_model_name}.active\n\tend\n"
      else
        file.puts "\n\tdef #{attr_name}_scope\n\t\t#{attr_name.capitalize}.active\n\tend\n"
      end
    end
  end
end

if $references_names.empty?
  file.puts "\n\tdef build_#{$name}\n\t\t@#{$name}          ||= #{$name}_scope.build\n\t\t@#{$name}.attributes = #{$name}_params\n\tend"
else
  line = "\n\tdef build_#{$name}"
  $attr_names.each do |attr_name|
    line << "\n\t\t@#{attr_name}s         ||= #{attr_name}_scope.to_a" if $references_names.include? attr_name
  end
  line << "\n\t\t@#{$name}          ||= #{$name}_scope.build\n\t\t@#{$name}.attributes = #{$name}_params\n\tend"
  file.puts line
end

line = "\n\tdef load_#{$name}\n\t\t@#{$name} ||= #{$name}_scope.find(params[:id])"
unless $references_names.empty?
  $attr_names.each do |attr_name|
    line << "\n\t\t@#{attr_name}_title = @#{$name}.#{attr_name}.title" if $references_names.include? attr_name
  end
end
line << "\n\tend"
file.puts line

line = "\n\tdef load_#{$names}"
unless $references_names.empty?
  $attr_names.each do |attr_name|
    line << "\n\t\t@#{attr_name}s ||= #{attr_name}_scope.to_a" if $references_names.include? attr_name
  end
end
line << "\n\t\t@#{$names} ||= #{$name}_scope.to_a\n\tend"
file.puts line

file.puts "\n\tdef save_#{$name}\n\t\tif @#{$name}.save\n\t\t\tredirect_to [:admin, @#{$name}], notice: '#{$model} was successfully created'\n\t\tend\n\tend"

file.puts "\n\t# Use callbacks to share common setup or constraints between actions"
file.puts "\tdef set_#{$name}\n\t\t@#{$name} = #{$model}.find(params[:id])\n\tend"

file.puts "\n\tdef update_#{$name}\n\t\tif @#{$name}.update(#{$name}_params)\n\t\t\tredirect_to [:admin, @#{$name}], notice: '#{$model} was successfully updated'\n\t\tend\n\tend"

file.puts "end"

file.close

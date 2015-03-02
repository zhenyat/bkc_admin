#!/usr/bin/env ruby
#################################################################################
#   helper_model.rb
#
#   Generates Admin Helper file for a Model: app/helpers/admin/<models>_helper.rb
#
#   01.02.2015  ZT
#   23.02.2015  v 1.0.0
#   01.03.2015  v 1.1.0   (sort_object helper added)
################################################################################

# admin directory
relative_path = 'app/helpers/admin'
admin_path    = "#{$app_root}/#{relative_path}"

action_report relative_path
Dir.mkdir(admin_path) unless File.exist?(admin_path)

# BKC Helper file
relative_path = "app/helpers/admin/bkc_helper.rb"
absolute_path = "#{$app_root}/#{relative_path}"

unless File.exist?(absolute_path)
  action_report relative_path

  file = File.open(absolute_path, 'w')

  file.puts "module Admin::BkcHelper"

  file.puts "  # Sorts array of objects by the Attribute (if passed)"
  file.puts "  def sort_objects objects_array, attribute=nil"
  file.puts "    if attribute.nil?"
  file.puts "      objects_array"
  file.puts "    else"
  file.puts '      objects_array.sort! { |a,b| eval("a.#{attribute} <=> b.#{attribute}") }'
  file.puts "    end"
  file.puts "  end"
  file.puts ""
  file.puts "  # Selects a status mark to be displayed"
  file.puts "  def status_mark status"
  file.puts "    if status == 'active'"
  file.puts "      image_tag('admin/checkmark.png', size: '12x15', alt: 'Актив')"
  file.puts "    else"
  file.puts "      image_tag('admin/archive.png',   size: '12x15', alt: 'Архив')"
  file.puts "    end"
  file.puts "  end"
  file.puts "end"

  file.close
end

# Create model helpers if FK exists   - Obsolete since v. 1.1.0
#unless $references_names.empty?
#  $references_names.each do |references_name|
#    relative_path = "app/helpers/admin/#{$names}_helper.rb"
#    absolute_path = "#{$app_root}/#{relative_path}"
#
#    unless File.exist?(absolute_path)
#      action_report relative_path
#
#      file = File.open(absolute_path, 'w')
#
#
#      file.puts "module Admin::#{$models}Helper"
#      file.puts "\n\  #Sorts array of #{references_name} by title}"
#      file.puts "  def #{references_name}s_sorted"
#      file.puts "    @#{references_name}s.sort! { |a,b| a.title <=> b.title }"
#      file.puts "#   @roles  if no sorting"
#      file.puts "  end"
#      file.puts "end"
#
#      file.close
#    end
#  end
#end
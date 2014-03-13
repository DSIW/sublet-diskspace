# -*- encoding: utf-8 -*-
# Diskspace specification file
# Created with sur-0.2
Sur::Specification.new do |s|
  # Sublet information
  s.name        = "Diskspace"
  s.version     = "0.1"
  s.tags        = [ "disk", "space", "free" ]
  s.files       = [ "diskspace.rb" ]
  s.icons       = [ "disk.xbm" ]

  # Sublet description
  s.description = "Left disk space on root partition"
  s.notes       = <<NOTES
"Shows how much left disk space you have on root partition. Source under http://github.com/DSIW/sublet-diskspace. Please contribute."
NOTES

  # Sublet authors
  s.authors     = [ "DSIW" ]
  s.contact     = "dsiw@dsiw-it.de"
  s.date        = "Thu Mar 13 20:17 CET 2014"

  # Sublet config
  s.config = [
    {
      :name        => "interval",
      :type        => "integer",
      :description => "Update interval in seconds.",
      :def_value   => "1800"
    },
    {
      :name        => "colors",
      :type        => "Hash",
      :description => "Hash of colors which will be displayed if percentage value is above.",
      :def_value   => '{98 => "#FF2525", 95 => "#C53535", 80 => "#A54545", 70 => "#955555", 60 => "#856565"}'
    },
    {
      :name        => "format_string",
      :type        => "String",
      :description => "Format string of left space.",
      :def_value   => "%.01f"
    },
    {
      :name        => "human_size",
      :type        => "String",
      :description => "Target size of left space. Possible values are: KB MB GB TB.",
      :def_value   => "GB"
    }
  ]

  # Sublet grabs
  #s.grabs = {
  #  :DiskspaceGrab => "Sublet grab"
  #}

  # Sublet requirements
  # s.required_version = "0.9.2127"
  # s.add_dependency("subtle", "~> 0.1.2")
end

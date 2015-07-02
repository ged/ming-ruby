# ming.rb - a library for generating Macromedia Flash (SWF)
# Copyright (C) 2004 IKEGAMI Daisuke <ikegami at madscientist dot jp>
#     All rights reserved.
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Library General Public
# License as published by the Free Software Foundation; either
# version 2 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Library General Public License for more details.
#
# You should have received a copy of the GNU Library General Public
# License along with this library; if not, write to the
# Free Software Foundation, Inc., 59 Temple Place - Suite 330,
# Boston, MA 02111-1307, USA.
#

require 'ming/mingc'
require 'find'

module Ming
  class SWFFont
    @@font_path = ['.']

    def SWFFont.font_path
      @@font_path
    end

    def SWFFont.new(filename)
      realname = SWFFont.search_font(filename)
      
      SWFFont.new_from_file(realname)
    end

    def SWFFont.search_font(filename)
      if File.basename(filename) == filename
        @@font_path.each do |rdir|
          if  /(.*)\/\/$/=~ rdir
            Find::find($1) do |path|
              filename = path if File.basename(path) == filename
            end
          else
            dir = Dir.open(rdir)
            dir.each do |path|
              filename = File.join(dir, path) if path == filename
            end
          end
        end
      end

      unless File.exist?(filename) 
        raise MingError, "file #{filename} is not found."
      end
      unless File.file?(filename)
        raise MingError, "file #{filename} is not regular font file."
      end
      unless File.readable?(filename)
        raise MingError, "file #{filename} cannot be read."
      end
      
      filename
    end

  end
end

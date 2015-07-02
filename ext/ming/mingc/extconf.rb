# extconf.rb for Ming/Ruby
# $Id$
#

require 'mkmf'

dir_config('freetype')
dir_config('ming')
dir_config('png')
dir_config('ungif')
dir_config('z')

@headers = ['ming.h'] 
@libs =    ['freetype', 'png', 'ungif', 'z', 'ming']
@missing = {
#  'basename' => ['char *basename(const char *path);', ['libgen.h']],
}
@specials = Hash.new

@headers.each do |file|
  unless have_header(file)
    raise "Cannot find Ming header file: #{file}"
  end
end

@libs.each do |lib|
  unless have_library(lib)
    raise "Cannot find Ming library for: #{lib}"
  end
end

@missing.values.each do |ary|
  ary[1].each do |f| 
    /(.*)\.h/ =~ f
    unless $defs.include?("-DHAVE_#{$1.upcase}_H")
      have_header(f) 
    end
  end
end

@missing.keys.each do |func|
  @missing[func][1].each do |header| 
    if have_func(func, header)
      @specials[func] = header
      break
    end
  end
  have_func(func) unless $defs.include?("-DHAVE_#{func.upcase}")
end

# Then, go for it.
@missing.keys.each do |func|
  open("missing/#{func}.h", 'w') do |fp|
    if @specials.keys.include?(func)
      fp.puts("#include <#{@specials[func]}>")
    else
      fp.puts(@missing[func][0])
    end
  end
end
create_header
create_makefile('mingc')

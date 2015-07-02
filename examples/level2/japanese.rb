# http://www.kumamushi.org/~k/ming

require 'ming/ming'
require 'uconv'
include Ming

$KCODE = 'e'

SWFFont.font_path.push('/site/data/fonts/fdb/fonts_j')

s = Uconv.euctou8('ÆüËÜ¸ì')
m = SWFMovie.new
f = SWFFont.new('marugoth.fdb') # you have to prepare the Japanese font

t = SWFText.new
t.set_font(f)
t.set_color(0x00, 0x70, 0xc0)
t.set_height(48)
t.add_string(s)
i = m.add(t)
i.move_to(100, 150)

m.save('japanese.swf')


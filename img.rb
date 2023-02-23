w = File.open('img.md', 'w')
w.print "# screenshots\n"

WAIT = 180

count = -1
File.foreach('quilt.csv') {|l|
  count += 1
  next if count == 0
  r = l.strip.split(',')
  (fn, cid) = r
  url = "https://optgeo.github.io/mille-plateaux/v.html?cid=#{cid}" 
  img_path = "img/#{fn}.png"
  wait = WAIT * 1000
  wait = wait * 2 if /_texture/.match fn
  cmd = <<-EOS
npx playwright screenshot --wait-for-timeout=#{wait} \
"#{url}" #{img_path}
  EOS
  w.print "[![#{fn}](#{img_path})](#{url})\n\n"
  print "#{count}: #{cmd}"
  system cmd
}

w.close

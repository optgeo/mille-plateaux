w = File.open('img.md', 'w')
w.print "# `mille-plateaux` collection\n"

WAIT = 300

count = -1
File.foreach('quilt.csv') {|l|
  count += 1
  next if count == 0
  r = l.strip.split(',')
  (fn, cid) = r
  url = "https://optgeo.github.io/mille-plateaux/v.html?cid=#{cid}" 
  img_path = "img/#{fn}.jpg"
  wait = WAIT * 1000
  wait = wait * 2 if /_texture/.match fn
  cmd = <<-EOS
npx playwright screenshot --wait-for-timeout=#{wait} \
"#{url}" #{img_path}
  EOS
  w.print <<-EOS
## #{fn}
[![#{fn}](#{img_path})](#{url})

  EOS
  w.flush
  next if File.exist?(img_path)
  print "#{count}: #{cmd}"
  system cmd
}

w.close

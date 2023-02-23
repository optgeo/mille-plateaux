w = File.open('img.md', 'w')
w.print "# screenshots\n"

count = -1
File.foreach('quilt.csv') {|l|
  count += 1
  next if count == 0
  r = l.strip.split(',')
  (fn, cid) = r
  url = "https://optgeo.github.io/mille-plateaux/v.html?cid=#{cid}" 
  img_path = "img/#{fn}.png"
  cmd = <<-EOS
npx playwright screenshot --wait-for-timeout=30000 \
"#{url}" #{img_path}
  EOS
  w.print "[![#{fn}](#{img_path})](#{url})\n\n"
  print "#{count}: #{cmd}\r"
  system cmd
}

w.close

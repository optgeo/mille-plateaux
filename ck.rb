count = -1
File.foreach('quilt.csv') {|l|
  count += 1
  next if count == 0
  r = l.strip.split(',')
  (fn, cid) = r
  print "ipfs ls /ipfs/#{cid}\n"
}


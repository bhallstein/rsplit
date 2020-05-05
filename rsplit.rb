#!/usr/bin/env ruby
#
# Simple replacement for split, written for a webhosting
# environment where split was not available
# 
# Ben Hallstein, 19.12.14
#

STDIN.binmode

def exitWUsageStr
  puts "Usage:  rsplit mb outname"
  exit
end

def getNewOutfile(name, n)
  digits = 2
  return File.new(name + n.to_s.rjust(digits, "0"), 'w')
end

def rsplit(split_mb, in_stream, outname)
  file_count = 0
  outfile = nil
  bytes_written_to_cur_file = nil
  bytes_at_a_time = 1000
  
  while chunk = STDIN.read(bytes_at_a_time)
    if outfile == nil or bytes_written_to_cur_file == split_mb * 1000000
      file_count += 1
      outfile.close if outfile
      outfile = getNewOutfile(outname, file_count)
      bytes_written_to_cur_file = 0
    end
    
    outfile.write(chunk)
    bytes_written_to_cur_file += bytes_at_a_time
  end
end

exitWUsageStr if (ARGV.count != 2)

p_split_mb = ARGV[0]
p_outname  = ARGV[1]
exitWUsageStr unless p_split_mb.match(/^[1-9]+[0-9]*$/)

rsplit(p_split_mb.to_i, STDIN, p_outname)

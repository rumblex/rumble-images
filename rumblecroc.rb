require 'rubygems'
require 'cgi'
require 'ping'

urls = []

File.open("./urls.txt", "r") do |infile|
  while (line = infile.gets)
    urls += line.split(/, /)
  end
end

`mkdir -p full`
`mkdir -p small`

counter = 0

urls.each do |url|
  puts CGI.escape(url) + " #{counter+=1}/#{urls.length}"
  # 30
  # 58
  # 151
  # 261
  # 273 ... popup alert
  # 335
next unless counter > 335
  unless Ping.pingecho(url.gsub(/http\:\/\//, ''), 5, 80)
    puts "============================================================================"
    puts "Server not available for #{url}"
    puts "============================================================================"
    next
  end
  `crocodile #{url} full/#{CGI.escape(url)}.png`
  `sips --resampleWidth 256 full/#{CGI.escape(url)}.png --out small/#{CGI.escape(url)}.png`
end

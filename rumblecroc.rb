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
  # 273 has a popup
  next if [30, 58, 151, 261, 335].include? current
  unless Ping.pingecho(url.gsub(/http\:\/\//, ''), 5, 80)
    puts "============================================================================"
    puts "Server not available for #{url}"
    puts "============================================================================"
    next
  end
  `crocodile #{url} full/#{url.gsub(/http:\/\//)}.png`
  `sips --resampleWidth 256 full/#{url.gsub(/http:\/\//)}.png --out small/#{url.gsub(/http:\/\//)}.png`
end

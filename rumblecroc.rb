require 'rubygems'
require 'cgi'
require 'json'

urls = []

File.open("./urls.txt", "r") do |infile|
  while (line = infile.gets)
    urls += line.split(/, /)
  end
end

counter = 0

urls.each do |url|
  puts CGI.escape(url) + " #{counter+=1}/#{urls.length}"
  `crocodile #{url} images/#{CGI.escape(url)}.jpg`
end


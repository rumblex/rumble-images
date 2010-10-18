start = Time.now
current = 0
count = Dir["full/*"].length
`mkdir -p movie`
`rm movie/*`
Dir["full/*"].each do |f| 
  # Setup the names
  url = 'http://'+f.gsub(/^full\//, '').gsub(/\.png$/, '')  
  converted = "%03d" % (current+=1)
  puts "(#{current}/#{count}, #{Time.now-start} elapsed) #{url}" 
  
  # resize to max width
  `convert #{f} -resize 852 movie/#{converted}.png`
  # crop
  `mogrify -gravity north -crop 852x480+0+0 movie/#{converted}.png`
  # poloroid
  poloroid = "convert movie/#{converted}.png \
     -bordercolor white  -border 6 \
     -bordercolor grey60 -border 1 \
     -bordercolor none  -background  none \
     \\( -clone 0 -rotate `convert null: -format '%[fx:rand()*30-15]' info:` \\) \
     \\( -clone 0 -rotate `convert null: -format '%[fx:rand()*30-15]' info:` \\) \
     \\( -clone 0 -rotate `convert null: -format '%[fx:rand()*30-15]' info:` \\) \
     \\( -clone 0 -rotate 0 \\) \
     -delete 0  -border 100x80  -gravity center \
     -crop 1280x720+0+0  +repage  -flatten  -trim +repage \
     -background black \\( +clone -shadow 60x4+4+4 \\) +swap \
     -background none  -flatten \
     movie/#{converted}.png"
  `#{poloroid}`   
  # re-crop
  `mogrify -gravity north -crop 1280x720+0+0 movie/#{converted}.png`
  `mogrify -gravity north -extent 1280x720+0+0 movie/#{converted}.png`
  # annotate
  `mogrify -fill white -undercolor '#000000C0' -gravity South -font Apple-LiGothic-Medium -style Normal -pointsize 36 -annotate +10+10 ' #{url} ' movie/#{converted}.png`
end

#-b 1800 
# ffmpeg -r 10 -i movie/%03d.png -b 1800 test.mp4
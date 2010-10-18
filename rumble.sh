crocodile http://railsrumble.com railsrumble.png
convert railsrumble.png -resize 852 movie/000.png
mogrify -gravity north -crop 852x480+0+0 movie/000.png
convert movie/000.png \
     -bordercolor white  -border 6 \
     -bordercolor grey60 -border 1 \
     -bordercolor none  -background  none \
     \( -clone 0 -rotate `convert null: -format '%[fx:rand()*30-15]' info:` \) \
     \( -clone 0 -rotate `convert null: -format '%[fx:rand()*30-15]' info:` \) \
     \( -clone 0 -rotate `convert null: -format '%[fx:rand()*30-15]' info:` \) \
     \( -clone 0 -rotate 0 \) \
     -delete 0  -border 100x80  -gravity center \
     -crop 1280x720+0+0  +repage  -flatten  -trim +repage \
     -background black \( +clone -shadow 60x4+4+4 \) +swap \
     -background none  -flatten \
     movie/000.png
mogrify -gravity north -crop 1280x720+0+0 movie/000.png
mogrify -gravity north -extent 1280x720+0+0 movie/000.png
mogrify -fill white -undercolor '#000000C0' -gravity South -font Helvetica-Neue-Condensed-Bold -pointsize 36 -annotate +10+10 ' railsrumble ' movie/000.png
mogrify -format jpg movie/000.png
cp movie/000.jpg movie/207.jpg



convert rumble_logo.png -gravity center -extent 1280x720+0+0 movie/207.png
mogrify -format jpg movie/207.png
cp movie/207.jpg movie/208.jpg

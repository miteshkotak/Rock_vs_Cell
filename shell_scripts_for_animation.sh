# Take frame pngs and send it through pix2pix
for file in ../../image_out/* ; do  python server/tools/process-local.py     --model_dir models/rocks_export2     --input_file "$file"     --output_file ../../rpimage/"${file#*image_out/}"; done

# Stitch images together with convert
for file in ./pimage/* ; do convert -background white -alpha remove image_out/"${file#*pimage/}" "$file" +append  side-by-side/"${file#*pimage/}" ; done

# Convert images to video with mencover
mencoder mf://side-by-side/* -mf w=512:h=256:fps=15:type=png -ovc copy -o output.avi

# Convert video to something more readable :)
ffmpeg -i output.avi -c:v libx264 -preset slow -crf 22 -c:a copy output.mp4


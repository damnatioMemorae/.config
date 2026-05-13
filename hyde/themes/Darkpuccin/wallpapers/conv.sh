for pic in $(ls); do
        gowall pixelate "$pic" -s 16 --output "$pic"_pix.png
done

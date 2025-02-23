#! /usr/bin/python3
# -*- coding: utf-8 -*-
import sys,os
from PIL import Image
from collections import Counter
## ad you own if missing, or if stack have various options
col="\033[0;32m"; _col="\033[0m"; purp="\033[0;35m"; green='\033[0;32m'; red='\033[93m'
print(";; copyleft ebecheto")
color_lists={
    1: ("TOP_M", "M5", "M4", "M3", "M2", "M1"),
    2: ("AP", "M9", "M8", "M7", "M6", "M5", "M4", "M3", "M2", "M1"),
    3: ("Metal3", "Metal2", "Metal1"),
    4: ("MET3", "MET2", "MET1"),
    5: ("TopMetal2", "TopMetal1", "Metal5", "Metal4", "Metal3", "Metal2", "Metal1"),
    6: ("TOP_M", "TOP_V", "M5", "V5", "M4","V4", "M3", "V3", "M2", "V2", "M1"),
    7: ("TOP_M", "TOP_V", "M5", "V5", "M4","V4", "M3", "V3", "M2", "V2", "M1", "CS", "GC"),
    8: ("AP", "M9", "VIA8", "M8", "VIA7", "M7", "VIA6", "M6", "VIA5", "M5", "VIA4", "M4", "VIA3", "M3", "VIA2", "M2", "VIA1", "M1")
}

tech = int(sys.argv[2]) if len(sys.argv) >2 else 1
sx   = float(sys.argv[3]) if len(sys.argv) >3 else 0.065
sy   = float(sys.argv[4]) if len(sys.argv) >4 else sx
YMAX = float(sys.argv[5]) if len(sys.argv) >5 else False

if len(sys.argv) <= 1:
    print(f"{col}USAGE: {_col}\npython script.py <image_path> <tech_number>")
    print(         "python script.py <image_path> <tech_number> <sx> <sy> <Height_in_um>")
    print(         "if fourth argument <Height_in_um> is given, sx and sy useless. final Heigth Size fix pixel")
    print(        f"python script.py image.png {tech} {sx} {sy} > image.il  #{purp}<= default{_col}")
    print(f"STEP (1): Choose your image, a tech number [1-{len(color_lists)}] a step-pixel in x or y.")
    print(f"STEP (2): load(\"image.il\") into CIW, with an open empty layout view")
    print(f"{red}The script will take the more frequence color of the image and for every pixel create a skill command to crerate that rectange. Then finaly merge all the layers{_col}")
    sys.exit(1)
image_path = sys.argv[1]

color_list=color_lists[tech]
nblayers=len(color_list)
#sx=0.065 #<== choose the step size eventally
#sy=sx

# USAGE
# Image need to be tuned before with few color layers only (bmp 4-bit or for instance)
# python ~/Skill/image2layers.py ~/groupU/Mi2i/pics/MICRHAU/Sami_idcrop_grey_b256.bmp > ~/stuff.il
# python ~/Skill/image2layers.py ~/groupU/Mi2i/WP5.1_comm/logos\ MI2I/Tous\ logos\ png/Logo-MI2I-horiz-black-base.png  5 > ih.il
# python ~/Skill/image2layers.py ~/groupU/Mi2i/ > ~/stuff.il
# Then in viruoso ; load("~/stuff.il")

# pip install pillow #<= requiered on the host
# prompter de gpt :EB

## geSelectAll() leMergeShapes(geGetSelectedSet()) dbSave(cv)
#convert Sami_idcrop_grey_b256.bmp  -format %c histogram:info:- |grep -v white |sort -rn |sed 's/#.*//; s/.*(/RGB_/; s/,/_/g;s/ //g;s/)/=/' |tac |tail -6

## RGB_192_192_192="TOP_M"
## RGB_255_251_240="M5"
## RGB_160_192_192="M4"
## RGB_160_160_164="M3"
## RGB_96_96_64=   "M2"
## RGB_64_96_128=  "M1"   


print("; CV=geGetWindowCellView()")
print("; identify -verbose  {image_path}")
print(";;RGB_x_x_x=\"M1\"  ;or:")
print("; RGB_x_x_x=list(\"M1\" \"drawing\")")

# Histogram:
#    32850: (  0,  0,  0) #000000 black
#      176: (  0,  0,128) #000080 navy
#        1: (  0,128,  0) #008000 green
#       96: (  0,128,128) #008080 teal
#    21529: (128,  0,  0) #800000 maroon
#       81: (128,  0,128) #800080 purple
#    20319: (128,128,  0) #808000 olive
#    49740: (128,128,128) #808080 fractal
#      183: (192,192,192) #C0C0C0 silver
#    63494: (255,255,255) #FFFFFF white


if os.path.splitext(image_path)[1] != ".bmp":
    # Open the image file
    with Image.open(image_path) as img:
        # Convert the image to 8-bit grayscale
        grayscale_img = img.convert("L")
        # Change the extension to .bmp for the output file
        output_bitmap_path = os.path.splitext(image_path)[0] + "_8b.bmp"
        # Save the image in bitmap format
        grayscale_img.save(output_bitmap_path, format="BMP")
        image_path = output_bitmap_path


def main():
    global sx, sy  # Use the global variables
    try:
        # Open the image file
        with Image.open(image_path) as img:
            # Ensure the image is in RGB mode
            img = img.convert('RGB')
            # Get image dimensions
            width, height = img.size
            # Get the list of all pixels in the image
            if YMAX :
                sx=sx*round(YMAX/(sx*height)) #; YMAX in 100 [um] /526 => 
                sy=sx
            pixels = list(img.getdata())
            # Count the frequency of each RGB color
            color_counter = Counter(pixels)
            # Sort colors by frequency
            sorted_colors = sorted(color_counter.items(), key=lambda item: item[1], reverse=True)
            for i, (color, count) in enumerate(sorted_colors[:nblayers]):
                r, g, b = color
                layer=color_list[i]
#                print(f"; RGB_{color} = \"M{i + 1}\" ; Frequency: {count}")
                print(f"RGB_{r}_{g}_{b} = \"{layer}\" ; Frequency: {count}")
            
            print(f"; TODO : Modif RGB_r_b_g header")
            print(f"; Image size: {width}x{height}")
            print(f"; identify -verbose {image_path}")
            print(f"; convert {image_path} -format %c histogram:info:- |grep -v white |sort -rn")

            # Loop through each pixel in the image
            for y in range(height):
                for x in range(width):
                    r, g, b = img.getpixel((x, y))
                    print(f"dbCreateRect(CV if(boundp('RGB_{r}_{g}_{b}) RGB_{r}_{g}_{b})||\"text\" ", end="")
                    print(f"list({x*sx}:{(height-y)*sy} {(x+1)*sx}:{(height-y-1)*sy} ))")
                    print(f"tf=techGetTechFile(CV)")
            
            print(f"leMergeShapes(CV~>shapes) dbSave(CV)")
            print(f"foreach(mapcar lpp '((\"LOGO\" \"drawing\")(\"DEV_AREA\" \"ext\")(\"AREA10\" \"opc\")) when(leIsLayerValid(lpp tf) dbCreateRect(CV lpp CV~>bBox)))")

    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()



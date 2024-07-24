#! /usr/bin/python3
import sys
from PIL import Image
from collections import Counter
## ad you own if missing, or if stack have various options
col="\033[0;32m"; _col="\033[0m"; purp="\033[0;35m"; green='\033[0;32m'; red='\033[93m'
print(";; copyleft ebecheto")
color_lists={
    1: ("TOP_M", "M5", "M4", "M3", "M2", "M1"),
    2: ("M9", "M8", "M7", "M6", "M5", "M4", "M3", "M2", "M1"),
    3: ("Metal3", "Metal2", "Metal1"),
    4: ("MET3", "MET2", "MET1"),
    5: ("TopMetal2", "TopMetal1", "Metal5", "Metal4", "Metal3", "Metal2", "Metal1"),
}

tech = int(sys.argv[2]) if len(sys.argv) >2 else 1
sx   = int(sys.argv[3]) if len(sys.argv) >3 else 0.065
sy   = int(sys.argv[4]) if len(sys.argv) >4 else sx

if len(sys.argv) <= 1:
    print(f"{col}USAGE: {_col}\npython script.py <image_path> <tech_number>")
    print(         "python script.py <image_path> <tech_number> <sx> <sy>")
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


print("cv=geGetWindowCellView()")
print("; identify -verbose  {image_path}")
print(";;RGB_x_x_x=\"M1\"  ;or:")
## print("RGB_255_255_255=\"M1\"")
## print("RGB_0_0_0=\"TOP_M\"")
## print("RGB_0_0_128=\"M5\"")
## print("RGB_128_0_0=\"M4\"")
## print("RGB_128_128_0=\"M3\"")
## print("RGB_128_128_128=\"M2\"")
## print("RGB_192_192_192=\"M1\"")
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
def main():

    try:
        # Open the image file
        with Image.open(image_path) as img:
            # Ensure the image is in RGB mode
            img = img.convert('RGB')
            # Get image dimensions
            width, height = img.size
            # Get the list of all pixels in the image
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
                    print(f"dbCreateRect(cv if(boundp('RGB_{r}_{g}_{b}) RGB_{r}_{g}_{b})||\"text\" ", end="")
                    print(f"list({x*sx}:{(height-y)*sy} {(x+1)*sx}:{(height-y-1)*sy} ))")
            
            print(f"geSelectAll() leMergeShapes(geGetSelectedSet()) dbSave(cv)")

    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()

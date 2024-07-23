#! /usr/bin/python3
import sys
from PIL import Image
from collections import Counter
color_list=("TOP_M", "M5", "M4", "M3", "M2", "M1")
color_list=("M9", "M8", "M7", "M6", "M5", "M4", "M3", "M2", "M1")
nblayers=len(color_list)

# Image need to be tuned before with few color layers only (bmp 4-bit or for instance)

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

## RGB_148_148_148="TOP_M"
## RGB_88_88_88   ="M5"  
## RGB_228_228_228="M4"  
## RGB_168_168_168="M3"  
## RGB_188_188_188="M2"  
## RGB_248_248_248="M1"  

## RGB_57_57_57=   "TOP_M"
## RGB_104_104_104="M5"   
## RGB_91_91_91=	"M4"   
## RGB_75_75_75=	"M3"   
## RGB_68_68_68=	"M2"   
## RGB_83_83_83=	"M1"   


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
    if len(sys.argv) != 2:
        print("Usage: python script.py <image_path>")
        sys.exit(1)

    image_path = sys.argv[1]

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
#                    print(f"Pixel at ({x}, {y}): R={r}, G={g}, B={b}")
                    print(f"dbCreateRect(cv if(boundp('RGB_{r}_{g}_{b}) RGB_{r}_{g}_{b})||\"text\" list({x}:{y} {x}+1:{y}+1 ))")
            
            print(f"geSelectAll() leMergeShapes(geGetSelectedSet()) dbSave(cv)")

    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()

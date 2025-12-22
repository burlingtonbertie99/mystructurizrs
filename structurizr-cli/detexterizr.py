#import os
#os.environ['path'] += r';C:\Program Files\UniConvertor-2.0rc5\dlls'
#import pathlib




from pathlib import Path
#from cairosvg import svg2png

import cairo
#import rsvg


from svglib.svglib import svg2rlg
from reportlab.graphics import renderPDF, renderPM
#import os

#path = "D:/Bla/Temp"
#os.chdir(path)




#path_to_here = pathlib.Path(os.getcwd())#
#last_part = path_to_here.parts[-1]
#print(last_part.endswith('ending'))

#img = cairo.ImageSurface(cairo.FORMAT_ARGB32, 640,480)

#ctx = cairo.Context(img)



for svg in Path(".").glob("*.svg"):
    text = svg.read_text(encoding="utf-8")
    text = text.replace(">[Deployment Node]<", "><")
    svg.write_text(text, encoding="utf-8")
    drawing = svg2rlg(svg)
    renderPM.drawToFile(drawing, "Pic.png")

#    handle = rsvg.Handle(None, str(svg))
#    handle.render_cairo(ctx)
#    img.write_to_png("svg.png")

#    svg2png(bytestring=svg, write_to='output001.png')




## handle = rsvg.Handle(<svg filename>)
# or, for in memory SVG data:





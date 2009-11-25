-- PUMICE Copyright (C) 2009 Lars Rosengreen (-*-coding:iso-safe-unix-*-)
-- released as free software under the terms of MIT open source license
--
-- Create a png image of a matrix.
-- may or may not be suitable for framing



matrix = require "matrix"
require "gd"

vis = {}

-- Create a grayscale image of the elements of a matrix, and save it
-- as a png to a file. Zero elements are white, the lagest elements are black
function vis.bw(M, filename)
   local rows, columns = M:size()
   local min, max = M:min(), M:max()
   local range = max - min 
   local scale = 255 / range
   local img = assert(gd.createTrueColor(rows, columns))
   local white = img:colorAllocate(255, 255, 255)
   img:filledRectangle(0, 0, rows - 1, columns - 1, white)
   for i, v in M:vects() do
      for j, e in v:elts() do
         local shade = 255 - math.floor((e - min) * scale)
         assert(shade >= 0 and shade <= 255)
         shade = img:colorAllocate(shade, shade, shade)
         img:setPixel(i - 1, j - 1, shade)
      end
   end
   img:png(filename)
end


function vis.mask(M, fname, maskColor)
   maskColor = maskColor or {0, 0, 0}
   local img = gd.create(M:size())
   local background = img:colorAllocateAlpha(255, 255, 255, 127)
   local mask = img:colorAllocateAlpha(maskColor[1], 
                                       maskColor[2], 
                                       maskColor[3], 0)
   for i, v in M:vects() do
      for j, e in v:elts() do
         img:setPixel(i - 1, j - 1, mask)
      end
   end
   img:png(fname)
end

-- PUMICE Copyright (C) 2009 Lars Rosengreen (-*-coding:iso-safe-unix-*-)
-- released as free software under the terms of MIT open source license
--
-- Create a png image of a matrix.
-- may or may not be suitable for framing



matrix = require "matrix"
require "gd"

-- Create a grayscale image of the elements of a matrix, and save it
-- as a png to a file.
local function vis(M, filename)
   local rows, columns = M:size()
   local min, max = M:min(), M:max()
   local range = max - min 
   local scale = 255 / range
   local img = assert(gd.createTrueColor(rows, columns))
   local white = img:colorAllocate(255, 255, 255)
   for i = 1, rows do
      for j = 1, columns do
         local e = M[i][j]
         local color = 255 - math.floor((e - min) * scale)
         assert(color >= 0 and color <= 255)
         color = img:colorAllocate(color, color, color)
         img:setPixel(i - 1, j - 1, color)
      end
   end
   img:png(filename)
   return
end


return vis
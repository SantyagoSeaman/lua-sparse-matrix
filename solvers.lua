-- PUMICE Copyright (C) 2009 Lars Rosengreen (-*-coding:iso-safe-unix-*-)
-- released as free software under the terms of MIT open source license

vector = require "vector"
matrix = require "matrix"

local solvers = {}

-- solve Ax = b using gaussian elimination with parital pivoting
-- returns x, the vector of solutions
function solvers.gepp(A, b)
   local rows, columns = A._rows, A._columns
   -- make a copy of A, otherwise the algorithm will modify the A that was 
   -- passed in.
   local A = A + matrix.new(rows, columns)
   local lambda = vector.new(rows)
   for i = 1, rows do
      lambda[i] = i
   end
   for k = 1, rows - 1 do
      local Amax = 0
      local imax = 0
      -- find column pivot positions
      for i = k, rows do
         local temp = math.abs(A[i][k])
         if temp > Amax then
            Amax = temp
            imax = i
         end
      end    
      -- swap rows of A
      A[k], A[imax] = A[imax], A[k]
      -- swap entries in lambda to remember pivots
      lambda[k], lambda[imax] = lambda[imax], lambda[k]
      -- calculate the multipliers
      for i = k + 1, rows do
         A[i][k] = A[i][k] / A[k][k]
      end
      -- update A
      for j = k + 1, rows do
         for i = k + 1, rows do
            A[i][j] = A[i][j] - A[i][k] * A[k][j]
         end
      end
   end
   -- Permute the right hand side as indicated by lambda
   local bh = vector.new(rows)
   for i = 1, rows do 
      bh[i] = b[lambda[i]];
   end
   -- Solve the lower triangular system Lc = b
   local c = vector.new(rows)
   for i = 1, rows do
      local sum = bh[i]
      for j = 1, i - 1 do
         sum = sum - A[i][j] * c[j]
      end
      c[i] = sum
   end
   -- Solve the upper triangular system, Uz = c
   local z = vector.new(rows);
   for i = rows, 1, -1 do
      local sum = c[i]
      for j = i + 1, rows do
         sum = sum - A[i][j] * z[j]
      end
      if A[i][i] == 0 then
         error("the algorithm fails")
      else
         z[i] = sum / A[i][i]
      end
   end
   -- permute the z vector to get the solution x (this
   -- step is required if there were any column switches
   local x = vector.new(rows)
   for i = 1, rows do
      x[i] = z[i]
   end
   return x
end


-- solve Au = b using conjugate gradients
function solvers.cgstep(A, b, steps, u0)
   local u = u0 or vector.new(b._size)
   local r = b - A * u
   local p = r
   for k = 1, steps do   
      local w = A * p
      local lambda = vector.dot(p, r) / vector.dot(p, w)
      u = u + lambda * p
      local rnew = r - lambda * w
      local alpha = vector.dot(rnew, rnew) / vector.dot(r, r)
      r = rnew
      p = r + alpha * p
   end
   return u
end


-- solve Au = b using the conjugate gradient method
-- 
-- A    - a square nxn matrix
-- b    - a vector of size n
-- eps  - stop iterating if norm of the residuals is smaller than this; 0 by 
--        default
-- step - stop after this many iterations; n by default
-- u0   - what to use as a best guess of the solutions; zero vector of n 
--        elements by default
--
-- returns u, the vector of the found solutions
function solvers.cg(A, b, eps, steps, u0)
   -- set defaults
   local ers = ers or 0
   local steps = steps or A._rows
   local u = u0 or vector.new(b._size)

   local r = b - A * u
   local p = r
   k = 1
   repeat
      local w = A * p
      local lambda = vector.dot(p, r) / vector.dot(p, w)
      u = u + lambda * p
      local rnew = r - lambda * w
      local alpha = vector.dot(rnew, rnew) / vector.dot(r, r)
      r = rnew
      p = r + alpha * p
      k = k + 1
   until k > steps or vector.norm(rnew) <= eps
   return u
end


return solvers
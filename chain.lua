local chain = {
  _VERSION     = 'chain 1.0.0',
  _DESCRIPTION = 'chaining updatable elements for lua',
  _URL         = 'https://github.com/aloisdeniel/chain.lua',
  _LICENSE     = [[
    MIT LICENSE

    Copyright (c) 2016 Alois Deniel

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  ]]
}

-- Instance

local Chain = {}
local Chain_mt = {__index = Chain}

function Chain:isFinished()
  return self.current > #self.elements
end

function Chain:update(dt)
  if self:isFinished() then return true end
    
  local currentFinished = true
  local current = self.elements[self.current]
  if type(current.update) == "function" then
    currentFinished = current:update(dt)
  else
    for _,element in ipairs(current) do
      currentFinished = element:update(dt) and currentFinished
    end
  end

  if currentFinished then self.current = self.current + 1 end
  
  return self:isFinished()
end

function Chain:reset()
  self.current = 1
  for _,element in ipairs(self.elements) do
    if element.clock > 0 then element:reset() end
  end
end

-- Public interface

function chain.new(elements)
  return setmetatable({
    elements = elements,
    current = 1
  }, Chain_mt)
end

return chain

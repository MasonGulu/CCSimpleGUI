--- A compact single-line widget that allows you to select a single element from a list.
-- Inherits from the widget object.
-- @see widget
-- @module scrollinput
local widget = require("ccsg.widget")

--- Defaults for the scrollinput widget
-- @table scrollinput
local scrollinput = {
  type = "scrollinput", -- string, used for gui packing/unpacking (must match filename without extension!)
  enable_events = true, -- bool, events are enabled by default for scrollinputs
  VERSION = "3.0",
}
-- Setup inheritence
setmetatable(scrollinput, widget)
scrollinput.__index = scrollinput

--- Draw the scrollinput widget.
function scrollinput:draw()
  self:clearClickable()
  local preppedString = string.sub(self.options[self.value], 1, self.size[1] - 1)
  self:write(preppedString, 2, 1)
  self:writeClickable(string.char(18), 1, 1)
end

--- Handle mouse_click events
-- @tparam number mouseButton
-- @tparam number mouseX
-- @tparam number mouseY
-- @treturn boolean mouseclick is on scroll button and enable_events
function scrollinput:handleMouseClick(mouseButton, mouseX, mouseY)
  local x, y = self:convertGlobalXYToLocalXY(mouseX, mouseY)
  if x == 1 and y == 1 then
    if mouseButton == 1 then
      self.value = self.value + 1
      if self.value > self.length then
        self.value = 1
      end
    elseif mouseButton == 2 then
      self.value = self.value - 1
      if self.value < 1 then
        self.value = self.length
      end
    end
    return self.enable_events
  end
  return false
end

--- Handle mousescroll events
-- @tparam int direction
-- @tparam int mouseX global X
-- @tparam int mouseY global Y
-- @treturn bool value has changed and enable_events
function scrollinput:handleMouseScroll(direction, mouseX, mouseY)
  if direction == 1 then
    self.value = self.value + 1
    if self.value > self.length then
      self.value = 1
    end
    return self.enable_events
  elseif direction == -1 then
    self.value = self.value - 1
    if self.value < 1 then
      self.value = self.length
    end
    return self.enable_events
  end
  return false
end

--- Handle key events
-- @tparam int key
-- @tparam int held
-- @treturn bool selected value changed and enable_events
function scrollinput:handleKey(key, held)
  if key == keys.down then
    self.value = self.value + 1
    if self.value > self.length then
      self.value = 1
    end
    return self.enable_events
  elseif key == keys.up then
    self.value = self.value - 1
    if self.value < 1 then
      self.value = self.length
    end
    return self.enable_events
  end
  return false
end

--- Update parameters of this scrollinput widget
-- @tparam table options
-- @tparam[opt] table p
function scrollinput:updateParameters(p)
  if p.options then
    self.value = 1
  end
  self:_applyParameters(p)
  self.length = #self.options
end

--- Create a new scrollinput widget.
-- @tparam table p requires options
-- @treturn table scrollinput object
function scrollinput.new(p)
  p.options = p.options or p[3]
  assert(type(p.options)=="table", "Scrollinput requires options")
  local o = widget.new(nil, p[1] or p.pos, p[2] or p.size, p)
  setmetatable(o, scrollinput)
  o.value = 1
  o:_applyParameters(p)
  o.length = #o.options
  return o
end

return scrollinput

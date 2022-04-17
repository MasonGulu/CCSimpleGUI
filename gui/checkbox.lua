--- A simple checkbox widget.
-- Inherits from the widget object.
-- @see widget
-- @module checkbox

local widget = require("gui/widget")

local checkbox = widget:new(nil, {1,1},{1,1})

--- Draw the checkbox widget.
function checkbox:draw()
    self:clear()
    if self.value then
        self:writeTextToLocalXY(string.char(7),1,1)
        -- closed checkbox
    else
        self:writeTextToLocalXY(string.char(164),1,1)
        -- open checkbox
    end
    local preppedString = self.text:sub(1, self.size[1]-3)
    self:writeTextToLocalXY(preppedString, 2, 1)
end

--- Handle mouse_click events.
-- @return enable_events, false by default
function checkbox:handleMouseClick(mouseButton, mouseX, mouseY)
    local x, y = self:convertGlobalXYToLocalXY(mouseX, mouseY)
    if x == 1 and y == 1 then
        self.value = not self.value
    end
    return self.enable_events
end

--- Create a new checkbox widget.
-- @param o original object, usually set to `nil`
-- @param pos table {x,y}
-- @param size table {width,height}
-- @param string String to display, single line.
-- @return checkbox widget
function checkbox:new(o,pos,size,text,p)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    o.pos = pos
    o.size = size
    o.focused = false
    o.value = false
    o.text = text
    if p then
        o.enable_events = p.enable_events or false
        o.device = p.device or term
    else
        o.enable_events = false
        o.device = term
    end
    return o
end

return checkbox
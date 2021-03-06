# GUI Library for ComputerCraft:Tweaked

This is a GUI library loosely inspired by PySimpleGUI intended for CC:Tweaked, but should function on just about any version of CC.

## Quickstart

Add the ccsg/ directory to your CC computer, include gui.lua, widget.lua, and any widget/extension files you'd like. To create a gui program first include what you require.

    local gui = require("ccsg.gui") -- required
    local text = require("ccsg.text")
    local button = require("ccsg.button")

Then create your window table/object

    local win = gui.new({
      text.new{{1,2}, {14,1}, label="Hello World!"}, -- position and size can be passed in through 1 and 2 indicies
      quit = button.new{pos={1,3}, size={14,1}, label="Quit!"}, -- or explicitly
      -- and the quit button is accessed through a key
    {autofit=true})

The first argument is a table of widgets, I set up a text and a button widget. The second argument is optional, it's a list of initial starting parameters for the gui, in this case I've enabled autofit, this means that the window I created will be centered in the terminal (this expects your top-left corner of your gui to be at 1,1). There is a `devMode` parameter, which when true allows dragging and resizing widgets with left/right click and will print out information about the selected widget on a middle click. More information can be found in the docs.

And finally set up your event loop.

    while true do
        local events, values, e = win:read()
        if events == "quit" then
            -- The "Quit!" button was pressed.
            term.clear()
            term.setCursorPos(1,1)
            break
        end
    end

In this snippet `events` contains either a `number`, `string` or `nil`, if it contains anything other than nil then that is the index of the widget which was interracted with. `values` contains a table of the values of each widget at the moment win:read returns (indexed by index of widget). `e` contains a table of the `{os.pullEvent()}` call.

You can access your widgets through `win.widgets` (or whatever you name your `win` object).

This example is located in `helloworld.lua`.

### Theming
You can change the theme of the gui by changing the key `theme` in your gui object. There are a few to pick from in `gui.lua`, or you can pass in your own.
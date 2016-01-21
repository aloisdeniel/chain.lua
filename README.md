# chain.lua

A tiny library for chaining updatable elements. It has been elaborated to be used in conjunction with [tween.lua](https://github.com/kikito/tween.lua) and [delay.lua](https://github.com/aloisdeniel/delay.lua) for creating complete animations or game cutscenes.

# Example

```lua
local tween = require 'tween'
local delay = require 'delay'
local chain = require 'chain'

local point = { x = 10, y = 10}
local point2 = { x = 50, y = 50}

local exampleChain = chain.new({
	tween.new(3,point, {x=100}, 'inOutSine'),
	delay.new(1),
	tween.new(3,point, {y=100}, 'inOutSine'),
	delay.new(1),
	{ tween.new(3,point, {y=100}, 'inOutSine'), tween.new(1,point2, {x=100, y=100}, 'inOutSine') } -- In parralel
})

if exampleChain:update(dt) then
	print("Finished !")
end
```

# Installation

Just copy the `chain.lua` file somewhere in your projects (maybe inside a `/lib/` folder) and require it accordingly.

## Copyright and license

MIT © [Aloïs Deniel](http://aloisdeniel.github.io)
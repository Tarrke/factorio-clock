
-- data:extend({hotkey})

require("gclock.style")

data:extend({
	{
	  type = "custom-input",
	  name = "toggle-chrono-key",
	  key_sequence = "SHIFT + C",
	  consuming = "script-only"
	}
})
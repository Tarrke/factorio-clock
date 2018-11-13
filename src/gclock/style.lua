local default_gui = data.raw["gui-style"].default

-- Font creation
data:extend({
    {
        type = "font",
        name = "gclock_font_default",
        from = "default-bold",
        size = 18
    }
})

--[[
default_gui["button_style"] = {
    type = "button_style",
    font = "gclock_font_default",
    -- Text align in button
    align = "center",
    vertical_align = "center",
    -- Default text color
    default_font_color = { r = 0, g = 1, b = 0, a = 1 }
    -- Color when the mouse hover the button
    hovered_font_color = { r = 0, g = 0, b = 1, a = 1 }
}
]]--

default_gui["gclock_button_default"] = {
    type = "button_style",
    font = "gclock_font_default",
    align = "center",
    vertical_align = "center"
}

default_gui["gclock_button_green"] = {
    type = "button_style",
    font = "gclock_font_default",
    align = "center",
    vertical_align = "center",
    default_font_color = { r = 0, g = 1, b = 0, a = 1 }
}

default_gui["gclock_button_red"] = {
    type = "button_style",
    font = "gclock_font_default",
    align = "center",
    vertical_align = "center",
    default_font_color = { r = 1, g = 0, b = 0, a = 1 }
}
--[[
-- written by Bekcpear
--]]

local gears   = require("gears")
local awful   = require("awful")
local wibox   = require("wibox")
local naughty = require("naughty")

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/my"

theme.wallpaper                                 = theme.dir .. "/wall.png"
theme.font                                      = "DejaVu Sans Mono 8"

theme.fg_normal                                 = "#bdbdbd"
theme.fg_focus                                  = "#ffffff"
theme.fg_urgent                                 = theme.fg_normal

theme.bg_normal                                 = "#000000"
theme.bg_focus                                  = "#000000"
theme.bg_urgent                                 = "#ef5350"

theme.graph_0                                   = "#78a4ff"
theme.graph_1                                   = "#ff7878"

theme.tasklist_fg_focus                         = theme.fg_normal
theme.tasklist_fg_normal                        = theme.fg_normal
theme.tasklist_bg_focus                         = theme.bg_focus
theme.tasklist_bg_normal                        = theme.bg_normal
theme.tasklist_spacing                          = 1
theme.tasklist_shape                            = gears.shape.rectangle
theme.tasklist_shape_focus                      = gears.shape.rounded_rect
theme.tasklist_shape_border_width_focus         = 0.5
theme.tasklist_shape_border_color_focus         = theme.fg_normal
theme.tasklist_fg_minimize                      = "#616161"
theme.tasklist_disable_icon                     = false

theme.taglist_fg_focus                          = theme.fg_focus
theme.taglist_fg_normal                         = theme.fg_normal
theme.taglist_bg_focus                          = "#111111"
theme.taglist_bg_normal                         = "#111111"

theme.titlebar_fg_normal                        = theme.tasklist_fg_minimize
theme.titlebar_fg_focus                         = theme.tasklist_fg_minimize
theme.titlebar_bg_normal                        = "#212121"
theme.titlebar_bg_focus                         = theme.bg_focus

theme.border_normal                             = theme.titlebar_bg_normal
theme.border_focus                              = theme.bg_focus
theme.border_width                              = 1

theme.useless_gap                               = 0
theme.menu_height                               = 16
theme.menu_width                                = 130

theme.awesome_icon                              = theme.dir .."/icons/awesome.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_unsel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"

theme.vol_ico                                   = theme.dir .. "/icons/vol.png"
theme.vol_low_ico                               = theme.dir .. "/icons/vol_low.png"
theme.vol_no_ico                                = theme.dir .. "/icons/vol_no.png"
theme.vol_mute_ico                              = theme.dir .. "/icons/vol_mute.png"

theme.net_ico                                   = theme.dir .. "/icons/net.png"

theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.layout_cornerse                           = theme.dir .. "/icons/cornerse.png"

theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

--{{{ Volume widget Start
-- theme.volicon & theme.sliderwidget can be used in rc.lua

-- init
local sliderbar = wibox.widget {
    bar_shape           = gears.shape.rounded_rect,
    bar_height          = 0.7,
    bar_color           = theme.border_color,
    forced_width        = 70,
    handle_color        = theme.fg_normal,
    handle_shape        = gears.shape.circle,
    handle_width        = 7,
    handle_border_width = 0,
    value               = 0,
    minimum             = 0,
    maximum             = 100,
    widget              = wibox.widget.slider,
}
theme.sliderwidget = wibox.container.margin(sliderbar, 0, 2)
theme.volicon = wibox.widget.imagebox(theme.vol_ico)

-- loop to check volume and is_muted
function getVolStat(stdout, stderr, reason, exit_code)
  if exit_code == 0 then
    mute, sliderbar.value = string.match(stdout, 'Mute:%s*(%a+)%s*[\r\n]*%s*Volume:[%s%a%d:-]+/%s+(%d+)')
    if mute == "yes" then sliderbar.handle_color = theme.bg_urgent
    else sliderbar.handle_color = theme.fg_normal end
  else
    naughty.notify({title = "Get initial volume err.", text = tostring(stderr), timeout = 0, fg = theme.taglist_fg_focus, bg = theme.bg_urgent})
  end
end

local vol_timer = gears.timer({ timeout = 2 })
vol_timer:start()
vol_timer:connect_signal("timeout", function()
    awful.spawn.easy_async("pactl list sinks", getVolStat)
  end
)
vol_timer:emit_signal("timeout")

-- binding click event
theme.sliderwidget:buttons(awful.util.table.join(
  awful.button({}, 3, function () 
    if sliderbar.handle_color == theme.fg_normal then sliderbar.handle_color = theme.bg_urgent
    else sliderbar.handle_color = theme.fg_normal end
  end),
  awful.button({}, 4, function ()
    sliderbar.value = sliderbar.value + 1
  end),
  awful.button({}, 5, function ()
    sliderbar.value = sliderbar.value - 1
  end)
  )
)

-- notify & change slider when volume changed
sliderbar:connect_signal("widget::redraw_needed", function(w)
  local muted = ''
  awful.spawn.with_shell(string.format("/bin/bash -c 'pactl set-sink-volume 0 %s' > /dev/null 2>&1", w.value .. "%"))
  if w.value == 0 then theme.volicon:set_image(theme.vol_no_ico)
  elseif w.value <= 50 then theme.volicon:set_image(theme.vol_low_ico)
  else theme.volicon:set_image(theme.vol_ico) end
  if sliderbar.handle_color == theme.bg_urgent then
    awful.spawn.with_shell("/bin/bash -c 'pactl set-sink-mute 0 1' > /dev/null 2>&1")
    muted = '[M]'
    theme.volicon:set_image(theme.vol_mute_ico)
  else
    awful.spawn.with_shell("/bin/bash -c 'pactl set-sink-mute 0 0' > /dev/null 2>&1")
  end
  naughty.destroy(naughty.getById(sliderbar.notify_id))
  sliderbar.notify_id = naughty.notify({text = "Vol: " .. tostring(w.value) .. "% " .. muted, timeout = 1}).id
  return true
end)
-- Volume widget End }}}
--
--{{{  Net traffic widget start
local netbar_up = wibox.widget {
  min_value         = 0,
  step_width        = 0.5,
  step_spacing      = 0.3,
  scale             = true,
  forced_width      = 80,
  color             = theme.graph_1,
  background_color  = theme.bg_normal,
  border_color      = theme.bg_normal,
  widget            = wibox.widget.graph
}
local netbar_do = wibox.widget {
  min_value         = 0,
  step_width        = 0.5,
  step_spacing      = 0.3,
  scale             = true,
  forced_width      = 80,
  color             = theme.graph_0,
  background_color  = theme.bg_normal,
  border_color      = theme.bg_normal,
  widget            = wibox.widget.graph
}
local netbar = wibox.widget {
  wibox.container.margin(wibox.container.mirror(netbar_do, {horizontal = true, vertical = true}), 0, 0, 2, 9),
  wibox.container.margin(wibox.container.mirror(netbar_up, {horizontal = true, vertical = false}), 0, 0, 9, 2),
  opacity = 0.7,
  layout  = wibox.layout.stack
}
local nettxt_unit = wibox.widget {
  text   = 'kBps',
  align  = 'center',
  valign = 'center',
  font   = 'DejaVu Sans Mono 6',
  widget = wibox.widget.textbox
}
local nettxt_sep = wibox.widget {
  text   = ' ',
  align  = 'center',
  valign = 'center',
  font   = 'DejaVu Sans Mono 6',
  widget = wibox.widget.textbox
}
local nettxt_symb_up = wibox.widget {
  text   = '↾',
  align  = 'left',
  valign = 'top',
  font   = 'DejaVu Sans Mono 6',
  widget = wibox.widget.textbox
}
local nettxt_up = wibox.widget {
  text   = '0.0',
  align  = 'left',
  valign = 'center',
  font   = 'DejaVu Sans Mono 8',
  widget = wibox.widget.textbox
}
local nettxtup = wibox.widget {
  nettxt_up,
  nettxt_symb_up,
  layout = wibox.layout.fixed.horizontal
}
local nettxt_symb_do = wibox.widget {
  text   = '⇃',
  align  = 'right',
  valign = 'bottom',
  font   = 'DejaVu Sans Mono 6',
  widget = wibox.widget.textbox
}
local nettxt_do = wibox.widget {
  text   = '0.0',
  align  = 'right',
  valign = 'center',
  font   = 'DejaVu Sans Mono 8',
  widget = wibox.widget.textbox
}
local nettxtdo = wibox.widget {
  nettxt_symb_do,
  nettxt_do,
  layout = wibox.layout.fixed.horizontal
}
local nettxt = wibox.widget {
  nettxtdo,
  nettxt_sep,
  nettxtup,
  forced_width = 80,
  layout = wibox.layout.align.horizontal
}
local netwithoutunit = wibox.widget {
  netbar,
  nettxt,
  layout  = wibox.layout.stack
}
theme.netwidget = wibox.widget {
  wibox.widget.imagebox(theme.net_ico),
  netwithoutunit,
  nettxt_unit,
  layout = wibox.layout.fixed.horizontal
}

-- read file
function file_read(name)
   local f = io.open(name,"r")
   local s = f:read()
   io.close(f)
   if s ~= nil then
     return s 
   else
     naughty.notify({title = "Net traffic monitor err.", text = string.format("Cannot read file %s", name), timeout = 0, fg = theme.taglist_fg_focus, bg = theme.bg_urgent})
     return false
   end
end
-- loop to check speed
local interface = 'enp0s31f6'
local carrier = string.format("/sys/class/net/%s/carrier", interface)
local tx      = string.format("/sys/class/net/%s/statistics/tx_bytes", interface)
local rx      = string.format("/sys/class/net/%s/statistics/rx_bytes", interface)

local vul     = file_read(carrier)
if vul ~= '0' then 
  local last_tx = 0
  local last_rx = 0
  local up      = 0
  local dw      = 0
  local now_tx  = tonumber(file_read(tx))
  local now_rx  = tonumber(file_read(rx))
  if now_rx >= 0 and now_tx >= 0 then
    local net_timer = gears.timer({ timeout = 2 })
    net_timer:start()
    net_timer:connect_signal("timeout", function()
        last_tx = now_tx
        last_rx = now_rx
        now_tx  = tonumber(file_read(tx))
        now_rx  = tonumber(file_read(rx))
        up      = (now_tx - last_tx) / 2048
        dw      = (now_rx - last_rx) / 2048
        if up > 1024 or dw > 1024 then
          nettxt_up.text = string.format("%.1f", up / 1024)
          nettxt_do.text = string.format("%.1f", dw / 1024)
          nettxt_unit.text = 'mBps'
        else
          nettxt_up.text = string.format("%.1f", up)
          nettxt_do.text = string.format("%.1f", dw)
          nettxt_unit.text = 'kBps'
        end
        netbar_up:add_value(up)
        netbar_do:add_value(dw)
      end
    )
  end
end
-- Net traffic widget End }}}

--{{{ Separator
theme.separator = wibox.widget {
  text         = '|',
  align        = 'center',
  font         = 'DejaVu Sans Mono 6',
  forced_width = 10,
  opacity      = 0.3,
  widget       = wibox.widget.textbox
}

-- Separator }}}
return theme

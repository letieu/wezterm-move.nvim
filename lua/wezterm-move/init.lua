local WM = {}

local wezterm_directions = { h = "Left", j = "Down", k = "Up", l = "Right" }

-- @param direction: string (h, j, k, l)
local function at_edge(direction)
  return vim.fn.winnr() == vim.fn.winnr(direction)
end

local function wezterm_exec(cmd)
  local command = vim.deepcopy(cmd)
  table.insert(command, 1, "wezterm")
  table.insert(command, 2, "cli")
  return vim.fn.system(command)
end

-- @param direction: string (h, j, k, l)
local function send_key_to_wezterm(direction)
  wezterm_exec({ "activate-pane-direction", wezterm_directions[direction] })
end

-- @param direction: string (h, j, k, l)
WM.move = function(direction)
  if at_edge(direction) then
    send_key_to_wezterm(direction)
  else
    vim.cmd("wincmd " .. direction)
  end
end

return WM

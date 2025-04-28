-- Lightly modified version of evil_lualine
-- https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua

-- Highlight colors
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

-- Conditions
local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  -- check_git_workspace = function()
  --    local filepath = vim.fn.expand('%:p:h')
  --    local gitdir = vim.fn.finddir('.git', filepath .. ';')
  --    return gitdir and #gitdir > 0 and #gitdir < #filepath
  --  end,
}

-- Defaults
local config = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = '',
    section_separators = { left = '', right = '' },
    always_divide_middle = true,
    globalstatus = true,
  },
  -- ---------------------------------------- --
  -- -- | A | B | C             	X | Y | Z | --
  -- ---------------------------------------- --
  sections = {
    -- Clearing defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- Insertin
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- Clearing defaults
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}

-- Insert component on the left (lualine_c section)
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Insert component on the right (lualine_x section)
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

-- Mode
ins_left {
  function()
    return ''
  end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = 1,
}

-- Filesize
ins_left {
  'filesize',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
}

-- Branch
ins_left { 
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
}

ins_left {
  'diff',
  symbols = { added = '󰐗 ', modified = '󰻂 ', removed = '󰍶 ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

-- Insert mid section
ins_left {
  function()
    return '%='
  end,
}

-- File type
ins_left {
  'filetype',
  colored = true,
  icon_only = true,
  icon = { align = 'right' },
}

-- File name
ins_left {
  'filename',
  path = 1,
  cond = conditions.buffer_not_empty,
}

-- LSP server name
ins_right {
  function()
    local noLSP = 'No LSP active'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
      return noLSP
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return noLSP
  end,
  icon = '  ',
  color = { fg = '#ffffff', gui = 'bold' },
}

-- Encoding
ins_right {
  'o:encoding',
  fmt = string.upper,
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' };
}

-- Diagnostics
ins_right {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.cyan },
  },
}

-- Location
ins_right { 'location' }

-- Progress
ins_right {
  'progress',
  color = { fg = colors.fg, gui = 'bold' }
}


-- Initialise lualine
require('lualine').setup(config)

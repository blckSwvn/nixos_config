vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.backup = false
vim.opt.undofile = true
vim.g.mapleader = " "
vim.opt.termguicolors = true

local m = vim.keymap.set
m("n", "<A-o>", ":Oil<CR>")
m("n", "<leader>q", ":q<CR>")
m("n", "<leader>y", '"+yy')
m("v", "<leader>y", '"+y')
m("n", "<leader>p", '"+p')
m("n", "<leader>P", '"+P')
m("n", "<A-j>", "<C-d>zz")
m("n", "<A-k>", "<C-u>zz")
m("n", "<leader>f", ":FzfLua files<CR>")
m("n", "<leader>s", ":FzfLua lsp_workspace_symbols<CR>")
m("n", "<leader>g", ":FzfLua grep<CR>")
m("n", "<leader>b", ":FzfLua buffers<CR>")
m("n", "<leader>z", ":FzfLua<CR>")
m("n", "<leader>d", ":FzfLua diagnostics_document<CR>")
m("n", "<leader>wv", "<C-w>v")
m("n", "<leader>wh", "<C-w>s")
m("n", "<leader>h",  "<C-w>h")
m("n", "<leader>j",  "<C-w>j")
m("n", "<leader>k",  "<C-w>k")
m("n", "<leader>l",  "<C-w>l")
m("n", "<leader>t", ":terminal<CR>")
m("t", "<C-Space>", [[<C-\><C-n>]])
m("n", "<C-h>", "<cmd>vertical resize -2<CR>")
m("n", "<C-j>", "<cmd>resize +2<CR>")
m("n", "<C-k>", "<cmd>resize -2<CR>")
m("n", "<C-l>", "<cmd>vertical resize +2<CR>")
m("n", "gd", vim.lsp.buf.definition)
m("n", "gD", vim.lsp.buf.declaration)
m("n", "gi", vim.lsp.buf.implementation)
m("n", "gr", vim.lsp.buf.references)
m("n", "<leader>r", vim.lsp.buf.rename)
m("n", "<leader>e", function()
  vim.diagnostic.open_float(nil, { border = "rounded" })
end)

local objects = {
  p = "(",
  c = "{",
  b = "[",
  q = '"',
  s = "'",
  t = "<",
}

for key, char in pairs(objects) do
  vim.keymap.set({ "o", "x" }, "i" .. key, "i" .. char)
  vim.keymap.set({ "o", "x" }, "a" .. key, "a" .. char)
end


vim.pack.add({
	{src = "https://github.com/leath-dub/snipe.nvim"},
	{src = "https://github.com/stevearc/oil.nvim"},
	{src = "https://github.com/nvim-tree/nvim-web-devicons"},
	{src = "https://github.com/kylechui/nvim-surround"},
	{src = "https://github.com/windwp/nvim-autopairs"},
	{src = "https://github.com/ibhagwan/fzf-lua"},
	{src = "https://github.com/neovim/nvim-lspconfig"},
	{src = "https://github.com/hrsh7th/nvim-cmp" },
	{src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{src = "https://github.com/rktjmp/lush.nvim"},
	{src = "https://github.com/hrsh7th/cmp-buffer" },
	{src = "https://github.com/hrsh7th/cmp-path" },
	{src = "https://github.com/lewis6991/gitsigns.nvim"},
})

require("oil").setup()

require("snipe").setup(
{
  ui = {
    ---@type "topleft"|"bottomleft"|"topright"|"bottomright"|"center"|"cursor"
    position = "center",
      border = "single", -- use "rounded" for rounded border
    },

    -- Preselect the currently open buffer
    preselect_current = true,
    -- Whether to remember mappings from bufnr -> tag
    persist_tags = true,
  navigate = {
    next_page = "J",
    prev_page = "K",

    under_cursor = "<Space>",
    close_buffer = "D",
    open_vsplit = "V",
    open_split = "H",

    -- Change tag manually (note only works if `persist_tags` is not enabled)
    -- change_tag = "C",
  },
  sort = "last",
}
)
m("n", "s", require("snipe").open_buffer_menu)
require("nvim-autopairs").setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config("lua_ls", { capabilities = capabilities })
vim.lsp.config("nixd", { capabilities = capabilities })
vim.lsp.config("clangd", { capabilities = capabilities })
vim.lsp.config("rust_analyzer", { capabilities = capabilities })
vim.lsp.enable({
  "lua_ls",
  "nixd",
  "clangd",
  "rust_analyzer",
})

vim.diagnostic.config({
  virtual_text = {
    severity = vim.diagnostic.severity.WARNING,
    spacing = 0,
    prefix = "",
  },
  underline = true,
  signs = true,
  update_in_insert = false,
})

local cmp = require"cmp"
cmp.setup({
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({select = true}),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
	}),
	sources = cmp.config.sources({
		{name = "nvim_lsp"},
		{name = "path"},
		{name = "buffer"},
	}),
})

-- LUSH THEME
local lush = require("lush")

local c = {
	fg       = "#C4C1B1",
	bg       = "#000000",
	black    = "#202020",
	gray     = "#505050",
	green    = "#43AF5A",
	yellow   = "#C1DB4B",
	blue     = "#26BFAD",
	orange   = "#E08B3E",
	red      = "#E05252",
	selection = "#A83493",
	comment  = "#C5C5C5",
}

local theme = lush(function()
	return {
		-- UI
		Normal       { fg = c.fg, bg = c.bg },
		Cursor       { fg = c.bg, bg = c.fg },
		CursorLine   { bg = c.black },
		CursorLineNr { fg = c.bg, bg = c.selection },

		Visual       { fg = c.fg, bg = c.selection },

		LineNr       { fg = c.fg },
		SignColumn   { bg = c.bg },
		FoldColumn   { fg = c.yellow, bg = c.bg },

		StatusLine   { fg = c.bg, bg = c.fg },
		StatusLineNC { fg = c.fg, bg = c.bg },

		VertSplit    { fg = c.black, bg = c.bg },
		WinSeparator { fg = c.black, bg = c.bg },

		TabLine      { fg = c.fg, bg = c.black },
		TabLineSel   { fg = c.bg, bg = c.fg },
		TabLineFill  { fg = c.fg, bg = c.black },

		Directory    { fg = c.fg },

		Pmenu        { fg = c.fg, bg = c.bg },
		PmenuSel     { fg = c.fg, bg = c.blue },
		PmenuSbar    { bg = c.black },
		PmenuThumb   { bg = c.gray },

		-- Virtual text / non-text UI
		NonText      { fg = c.gray },
		SpecialKey   { fg = c.gray },
		Folded       { fg = c.fg, bg = c.black },

		-- Language
		Comment      { fg = c.comment, gui = "italic,bold" },
		String       { fg = c.green },
		Constant     { fg = c.green },
		Boolean      { fg = c.green },

		Number       { fg = c.green },
		Float        { fg = c.green },

		Type         { fg = c.yellow },
		StorageClass { fg = c.fg },
		Structure    { fg = c.yellow },

		Function     { fg = c.blue },
		Identifier   { fg = c.fg },
		Variable     { fg = c.fg },

		Keyword      { fg = c.fg },
		Conditional  { fg = c.fg },
		Repeat       { fg = c.fg },
		Label        { fg = c.fg },
		Operator     { fg = c.fg },

		PreProc      { fg = c.fg },
		Include      { fg = c.fg },
		Define       { fg = c.fg },
		Macro        { fg = c.fg },

		Special      { fg = c.fg },
		SpecialChar  { fg = c.fg },
		Delimiter    { fg = c.fg },

		-- Markup
		Title        { fg = c.blue, gui = "bold" },

		-- Diagnostics
		DiagnosticError { fg = c.red },
		DiagnosticWarn  { fg = c.orange },
		DiagnosticInfo  { fg = c.blue },
		DiagnosticHint  { fg = c.orange },

		Error          { fg = c.red },
		WarningMsg     { fg = c.orange },
		Info           { fg = c.blue },

		-- Diagnostic underlines
		DiagnosticUnderlineError {
			gui = "undercurl",
			sp = c.red,
		},

		DiagnosticUnderlineWarn {
			gui = "undercurl",
			sp = c.orange,
		},

		DiagnosticUnderlineInfo {
			gui = "undercurl",
			sp = c.fg,
		},

		DiagnosticUnderlineHint {
			gui = "undercurl",
			sp = c.blue,
		},

		DiagnosticUnderlineUnnecessary {
			gui = "underline",
			sp = c.fg,
		},

		-- Matching cursor / brackets
		CursorColumn { bg = c.black },
		MatchParen   { bg = c.selection },

		-- Search
		Search       { fg = c.fg, bg = c.selection },
		IncSearch    { fg = c.bg, bg = c.fg },
		CurSearch    { fg = c.bg, bg = c.fg },
	}
end)

lush(theme)

-- Explicit overrides
vim.api.nvim_set_hl(0, "CursorLineNr", {
	fg = c.bg,
	bg = c.selection,
})

vim.api.nvim_set_hl(0, "StatusLine", {
	fg = c.bg,
	bg = c.fg,
})

vim.api.nvim_set_hl(0, "StatusLineNC", {
	fg = c.fg,
	bg = c.bg,
})

vim.api.nvim_set_hl(0, "TabLineSel", {
	fg = c.bg,
	bg = c.fg,
})

vim.api.nvim_set_hl(0, "TabLine", {
	fg = c.fg,
	bg = c.black,
})

vim.api.nvim_set_hl(0, "VertSplit", {
	fg = c.black,
	bg = c.bg,
})

vim.api.nvim_set_hl(0, "WinSeparator", {
	fg = c.black,
	bg = c.bg,
})

vim.api.nvim_set_hl(0, "FoldColumn", {
	fg = c.yellow,
	bg = c.bg,
})

vim.api.nvim_set_hl(0, "Folded", {
	fg = c.fg,
	bg = c.black,
})

-- Popup menu
vim.api.nvim_set_hl(0, "Pmenu", {
	fg = c.fg,
	bg = c.bg,
})

vim.api.nvim_set_hl(0, "PmenuSel", {
	fg = c.fg,
	bg = c.blue,
})

-- Virtual text
vim.api.nvim_set_hl(0, "NonText", {
	fg = c.gray,
})

vim.api.nvim_set_hl(0, "SpecialKey", {
	fg = c.gray,
})

-- GitSigns
vim.api.nvim_set_hl(0, "GitSignsAdd", {
	fg = c.green,
})

vim.api.nvim_set_hl(0, "GitSignsAddLn", {
	fg = c.green,
})

vim.api.nvim_set_hl(0, "GitSignsAddNr", {
	fg = c.green,
})

vim.api.nvim_set_hl(0, "GitSignsChange", {
	fg = c.blue,
})

vim.api.nvim_set_hl(0, "GitSignsChangeLn", {
	fg = c.blue,
})

vim.api.nvim_set_hl(0, "GitSignsChangeNr", {
	fg = c.blue,
})

vim.api.nvim_set_hl(0, "GitSignsRemove", {
	fg = c.fg,
})

vim.api.nvim_set_hl(0, "GitSignsRemoveLn", {
	fg = c.fg,
})

vim.api.nvim_set_hl(0, "GitSignsRemoveNr", {
	fg = c.fg,
})

-- Optional: keep the editor completely black outside the active UI
vim.api.nvim_set_hl(0, "NormalFloat", {
	fg = c.fg,
	bg = c.bg,
})

vim.api.nvim_set_hl(0, "FloatBorder", {
	fg = c.black,
	bg = c.bg,
})

-- vim.api.nvim_set_hl(0, "TabLineSel",   {fg = c.black, bg = c.blue})
-- vim.api.nvim_set_hl(0, "MarkSignHL",   {fg = c.blue,  bg = c.bg})
-- vim.api.nvim_set_hl(0, "StatusLine",   {fg = c.black, bg = c.blue, bold = true })
-- vim.api.nvim_set_hl(0, "StatusLineNC", {fg = c.fg,    bg = c.bg })
-- vim.api.nvim_set_hl(0, "VertSplit",    {fg = c.black, bg = c.blue})
-- vim.api.nvim_set_hl(0, "Foldcolumn",   {fg = c.yellow})
-- vim.api.nvim_set_hl(0, "Folded",       {fg = c.fg})

-- vim.api.nvim_set_hl(0, "GitSignsAdd",  {fg = c.green})
-- vim.api.nvim_set_hl(0, "GitSignsAddLn",  {fg = c.green})
-- vim.api.nvim_set_hl(0, "GitSignsAddNr",  {fg = c.green})
-- vim.api.nvim_set_hl(0, "GitSignsChange",  {fg = c.blue})
-- vim.api.nvim_set_hl(0, "GitSignsChangeLn",  {fg = c.blue})
-- vim.api.nvim_set_hl(0, "GitSignsChangeNr",  {fg = c.blue})
-- vim.api.nvim_set_hl(0, "GitSignsRemove",  {fg = c.fg})
-- vim.api.nvim_set_hl(0, "GitSignsRemoveLn",  {fg = c.fg})
-- vim.api.nvim_set_hl(0, "GitSignsRemoveNr",  {fg = c.fg})

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
m("n", "<leader>y", '"+yy')
m("v", "<leader>y", '"+y')
m("n", "<leader>p", '"+p')
m("n", "<leader>P", '"+P')
m("n", "<C-d>", "<C-d>zz")
m("n", "<C-u>", "<C-u>zz")
m("n", "<leader>f", ":FzfLua files<CR>")
m("n", "<leader>s", ":FzfLua lsp_workspace_symbols<CR>")
m("n", "<leader>g", ":FzfLua grep<CR>")
m("n", "<leader>b", ":FzfLua buffers<CR>")
m("n", "<leader>z", ":FzfLua<CR>")
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
	fg       = "#DADADA",
	bg       = "#000000",
	black    = "#202020",
	b_black  = "#505050",
	green    = "#2db64A",
	yellow   = "#f0bf00",
	blue     = "#4472CA",
	orange   = "#3FC8B3",
	red      = "#DA2C38",
}

local theme = lush(function()
	return {
		lineNr	    {fg = c.fg},
		CursorLineNr{fg = c.blue, gui = "bold"},
		CursorLine  {bg = c.black},
		Visual      {bg = c.blue, fg = c.fg},
		Normal      {fg = c.fg,   bg = c.bg },
		Cursor      {fg = c.bg,   bg = c.fg },
		Comment     {fg = c.fg, bg = c.black },

		-- Language
		String      {fg = c.green},
		Boolean     {fg = c.fg},
		Constant    {fg = c.green},
		Number      {fg = c.fg},     -- cooler than yellow
		Type        {fg = c.yellow},
		Keyword     {fg = c.fg},
		PreProc     {fg = c.fg}, -- #includes, macros
		Conditional {fg = c.fg},      -- if/else, etc.
		Function    {fg = c.blue},
		Identifier  {fg = c.fg},

		-- Operators and misc
		Operator    {fg = c.fg},              -- neutral, avoids rainbow
		Special     {fg = c.fg},     -- escape chars, regex, unusual

		-- UI
		Directory   {fg = c.fg},
		Error       {bg = c.red},
		WarningMsg  {fg = c.red },
		Info        {fg = c.orange},

		StatusLine  { fg = c.fg,      bg = c.black },
		StatusLineNC{ fg = c.b_black, bg = c.black },

		DiagnosticError { bg = c.red},
		DiagnosticWarn  { fg = c.red},
		DiagnosticInfo  { fg = c.blue},
		DiagnosticHint  { fg = c.orange},
	}
end)
lush(theme)

vim.api.nvim_set_hl(0, "TabLineSel",   {fg = c.black, bg = c.blue})
vim.api.nvim_set_hl(0, "MarkSignHL",   {fg = c.blue,  bg = c.bg})
vim.api.nvim_set_hl(0, "StatusLine",   {fg = c.black, bg = c.blue, bold = true })
vim.api.nvim_set_hl(0, "StatusLineNC", {fg = c.fg,    bg = c.bg })
vim.api.nvim_set_hl(0, "VertSplit",    {fg = c.black, bg = c.blue})
vim.api.nvim_set_hl(0, "Foldcolumn",   {fg = c.yellow})
vim.api.nvim_set_hl(0, "Folded",       {fg = c.fg})

vim.api.nvim_set_hl(0, "GitSignsAdd",  {fg = c.green})
vim.api.nvim_set_hl(0, "GitSignsAddLn",  {fg = c.green})
vim.api.nvim_set_hl(0, "GitSignsAddNr",  {fg = c.green})
vim.api.nvim_set_hl(0, "GitSignsChange",  {fg = c.blue})
vim.api.nvim_set_hl(0, "GitSignsChangeLn",  {fg = c.blue})
vim.api.nvim_set_hl(0, "GitSignsChangeNr",  {fg = c.blue})
vim.api.nvim_set_hl(0, "GitSignsRemove",  {fg = c.fg})
vim.api.nvim_set_hl(0, "GitSignsRemoveLn",  {fg = c.fg})
vim.api.nvim_set_hl(0, "GitSignsRemoveNr",  {fg = c.fg})

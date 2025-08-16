return {
	'vague2k/vague.nvim',
	config = function()
		require('vague').setup({
			transparent = true,
			style = {
				-- "none" is the same thing as default. But "italic" and "bold" are also valid options
				boolean = 'none',
				number = 'none',
				float = 'none',
				error = 'none',
				comments = 'none',
				conditionals = 'none',
				functions = 'none',
				headings = 'bold',
				operators = 'none',
				strings = 'none',
				variables = 'none',

				-- keywords
				keywords = 'none',
				keyword_return = 'none',
				keywords_loop = 'none',
				keywords_label = 'none',
				keywords_exception = 'none',

				-- builtin
				builtin_constants = 'none',
				builtin_functions = 'none',
				builtin_types = 'none',
				builtin_variables = 'none',
			},
		})
		vim.cmd.colorscheme('vague')
		vim.cmd(':hi statusline guibg=NONE')
	end,
}

-- USER FUNCTIONS >>>>>>>>>>

local function clean_urls()
	-- removes http/https protocol, www., query parameters and trailing slashes
	local substitutions = {
		{ "http:\\/\\/", "" },
		{ "https:\\/\\/", "" },
		{ "\\r", "" },
		{ "www\\.", "" },
		{ "?.*", "" },
		{ "\\/$", "" },
	}

	local buf = vim.api.nvim_get_current_buf()

	for _, sub in ipairs(substitutions) do
		local search = sub[1]
		local replace = sub[2]
		pcall(function()
			vim.api.nvim_buf_call(buf, function()
				vim.cmd(string.format("%%s/%s/%s/g", search, replace))
			end)
		end)
	end
end

-- Expose the function as a command
vim.api.nvim_create_user_command("CleanURLs", clean_urls, {})

local function add_quotes()
	local buf = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

	for i, line in ipairs(lines) do
		if i == #lines then
			lines[i] = '"' .. line .. '"'
		else
			lines[i] = '"' .. line .. '",'
		end
	end
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

-- Create a command to call the function
vim.api.nvim_create_user_command("AddQuotes", add_quotes, {})

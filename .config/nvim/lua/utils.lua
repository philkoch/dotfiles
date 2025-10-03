local M = {}

function M.get_poetry_venv()
	if vim.fn.filereadable("poetry.lock") == 0 then
		return nil
	end
	local project_name = nil
	for line in io.lines("pyproject.toml") do
		project_name = line:match('^name%s*=%s*"(.-)"')
		if project_name then
			break
		end
	end
	if not project_name then
		vim.notify("Didn't find name in pyproject.toml. Unable to load poetry venv!", vim.log.levels.ERROR)
		return nil
	end

	local poetry_home = vim.fn.expand("~/.cache/pypoetry/virtualenvs/")
	local venv_pattern = project_name .. "-"
	for _, venv in ipairs(vim.fn.glob(poetry_home .. venv_pattern .. "*", true, true)) do
		if vim.fn.isdirectory(venv) == 1 then
			return venv
		end
	end
	vim.notify("Unable to load poetry venv!", vim.log.levels.ERROR)
	return nil
end

function M.run_template_open_view(opts)
	-- opens the task view when a template is run
	-- see https://github.com/stevearc/overseer.nvim/issues/36#issuecomment-1238715487
	local overseer = require("overseer")
	overseer.run_template(opts, function(task)
		if task then
			overseer.open({ enter = false })
		end
	end)
end

function M.find_project_root(start_path)
	local pyproject_paths = vim.fs.find("pyproject.toml", {
		upward = true,
		path = start_path,
		stop = vim.fn.getcwd(),
	})

	for _, path in ipairs(pyproject_paths) do
		local dir = vim.fs.dirname(path)
		if dir:match("/packages/[^/]+$") then
			return dir
		end
	end

	-- kein packages/*/pyproject.toml gefunden → Root verwenden?
	local first = pyproject_paths[1]
	if first and vim.fs.dirname(first) == vim.fn.getcwd() then
		return vim.fn.getcwd()
	end

	return vim.fn.getcwd() -- absoluter fallback
end

return M

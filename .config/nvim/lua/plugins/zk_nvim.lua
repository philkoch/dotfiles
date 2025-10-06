return {
	"zk-org/zk-nvim",
	lazy = true,
	keys = function()
		local zk = require("zk")
		local function create_zk_note()
			vim.ui.input({ prompt = "Enter title for the new note: " }, function(title)
				if title and title ~= "" then
					zk.new({ title = title, template = "zettel" })
				else
					vim.notify("No title provided. Note creation cancelled.", vim.log.levels.WARN)
				end
			end)
		end
		local function create_zk_project()
			vim.ui.input({ prompt = "Enter title for the new project: " }, function(title)
				if title and title ~= "" then
					zk.new({ title = title, group = "projects" })
				else
					vim.notify("No title provided. Project creation cancelled.", vim.log.levels.WARN)
				end
			end)
		end
		local function create_zk_resource()
			vim.ui.input({ prompt = "Enter title for the new resource: " }, function(title)
				if title and title ~= "" then
					zk.new({ title = title, group = "resources" })
				else
					vim.notify("No title provided. Resource creation cancelled.", vim.log.levels.WARN)
				end
			end)
		end
		return {
			{ "<leader>zn", create_zk_note, desc = "   New Zettel" },
			{ "<leader>zp", create_zk_project, desc = "󱨰   New Project" },
			{ "<leader>zr", create_zk_resource, desc = "󱘎  New Resource" },
			{ "<leader>zj", "<cmd>ZkNew { dir = 'journal' }<CR>", desc = "   New Journal" },
			{ "<leader>zfn", "<cmd>ZkNotes<CR>", desc = "  Find notes" },
			{ "<leader>zft", "<cmd>ZkTags<CR>", desc = "  Find tags" },
		}
	end,
	config = function()
		require("zk").setup()
	end,
}

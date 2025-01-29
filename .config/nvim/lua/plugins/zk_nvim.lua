return {
	"zk-org/zk-nvim",
	keys = function()
		local zk = require("zk")
		local function create_zk_note()
			vim.ui.input({ prompt = "Enter title for the new note: " }, function(title)
				if title and title ~= "" then
					zk.new({ title = title, template = "zettel" })
				else
					-- Falls kein Titel eingegeben wurde
					vim.notify("No title provided. Note creation cancelled.", vim.log.levels.WARN)
				end
			end)
		end
		return {
			{ "<leader>z", desc = " ZETTELKASTEN" },
			{ "<leader>zn", create_zk_note, desc = "New Zettel" },
			{ "<leader>zj", "<cmd>ZkNew { dir = 'journal' }<CR>", desc = "New Journal" },
		}
	end,
	config = function()
		require("zk").setup()
	end,
}

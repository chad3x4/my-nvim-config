local conf = require("telescope.config").values
local themes = require("telescope.themes")

-- helper function to use telescope on harpoon list.
-- change get_ivy to other themes if wanted
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end
	local opts = themes.get_ivy({
		promt_title = "Working List",
	})

	require("telescope.pickers")
		.new(opts, {
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer(opts),
			sorter = conf.generic_sorter(opts),
		})
		:find()
end

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		local keymap = vim.keymap
		keymap.set("n", "<leader>aa", function()
			harpoon:list():add()
		end, { desc = "Add to harpoon" })
		keymap.set("n", "<leader>ar", function()
			harpoon:list():remove()
		end, { desc = "Remove from harpoon" })
		keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Open harpoon menu" })
		keymap.set("n", "<leader>fl", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Open harpoon window" })
		keymap.set("n", "<C-p>", function()
			harpoon:list():prev()
		end, { desc = "Previous file in harpoon" })
		keymap.set("n", "<C-n>", function()
			harpoon:list():next()
		end, { desc = "Next file in harpoon" })
	end,
}

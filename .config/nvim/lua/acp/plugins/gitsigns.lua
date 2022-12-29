-- import gitsigns plugin safely
local setup, gitsigns = pcall(require, "gitsigns")

-- configure/enable gitsigns
gitsigns.setup()

-- import comment plugin safely
local setup, comment = pcall(require, "Comment")

-- enable comment
comment.setup()

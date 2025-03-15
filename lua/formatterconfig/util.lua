local conform = require("conform")

local M = {}

M.default_config = {
    autostart = function(self, source)
        local directory = vim.fs.root(source, self.root_markers)
        if directory == nil then
            return false
        end
        conform.formatters[self.name] =
        vim.tbl_deep_extend("keep", self.conform_overrides, conform.formatters[self.name] or {})
        return true
    end,
    conform_overrides = vim.empty_dict(),
}

return M

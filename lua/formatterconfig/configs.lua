local configs = {}

local util = require("formatterconfig.util")
local api = vim.api
local tbl_deep_extend, tbl_filter, tbl_contains = vim.tbl_deep_extend, vim.tbl_filter, vim.tbl_contains

local conform = require("conform")

--- @class formatterconfig.Config
--- @field name? string
--- @field filetypes? string[]
--- @field root_markers? string[]
--- @field autostart? fun(self: table, source: integer|string)
--- @field conform_overrides? table

---@param t table
---@param config_name string
---@param config_def table Config definition read from `formatterconfig.configs.<name>`.
function configs.__newindex(t, config_name, config_def)
    local M = {}

    local default_config = tbl_deep_extend("keep", config_def.default_config, util.default_config)

    -- Force this part.
    default_config.name = config_name

    --- @param user_config formatterconfig.Config
    function M.setup(user_config)
        user_config = user_config or {}

        local formatter_group = api.nvim_create_augroup("formatterconfig", { clear = false })

        local config = tbl_deep_extend("keep", user_config, default_config)

        ---@param opts table options dict for api.nvim_create_autocmd containing opts.buf
        local function update_formatter(opts)
            local ft = vim.bo[opts.buf].filetype
            if tbl_contains(config.filetypes, ft) == false then
                return
            end

            if config.autostart(config, opts.buf) == true then
                conform.formatters_by_ft[ft] =
                    tbl_deep_extend("keep", { config.name }, conform.formatters_by_ft[ft] or {})
            elseif conform.formatters_by_ft[ft] then
                local filtered = tbl_filter(
                    function(entry) return entry ~= config.name end,
                    conform.formatters_by_ft[ft]
                )
                if #filtered == 0 then
                    conform.formatters_by_ft[ft] = nil
                else
                    conform.formatters_by_ft[ft] = filtered
                end
            end
        end

        api.nvim_create_autocmd("BufEnter", {
            callback = update_formatter,
            group = formatter_group,
            desc = string.format("Checks whether formatter %s should start and updates conform.nvim.", config.name),
        })
        update_formatter({ buf = api.nvim_get_current_buf() })
    end

    rawset(t, config_name, M)
end

return setmetatable({}, configs)

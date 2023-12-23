local config = require("randiverse.config")

local M = {}

--- Cursor helper functions
-- TODO: Random is being placed -1 before where it should..
M.get_curpos = function()
    local curpos = vim.api.nvim_win_get_cursor(0)
    return { curpos[1], curpos[2] + 1 }
end

M.set_curpos = function(pos)
    if not pos then
        return
    end
    vim.api.nvim_win_set_cursor(0, { pos[1], pos[2] - 1 })
end

M.reset_curpos = function(pos)
    if config.get_opts().move_cursor == "begin" then
        M.set_curpos(pos.first_pos)
    elseif not config.get_opts().move_cursor then
        M.set_curpos(pos.old_pos)
    end
end

M.get_lines = function(start, stop)
    return vim.api.nvim_buf_get_lines(0, start - 1, stop, false)
end

M.get_line = function(line_num)
    return M.get_lines(line_num, line_num)[1]
end

M.insert_text = function(pos, text)
    pos[2] = math.min(pos[2], #M.get_line(pos[1]) + 1)
    vim.api.nvim_buf_set_text(0, pos[1] - 1, pos[2] - 1, pos[1] - 1, pos[2] - 1, { text })
end

M.curpos_insert_text = function(text)
    local curpos = M.get_curpos()
    M.insert_text(curpos, text)
end

return M

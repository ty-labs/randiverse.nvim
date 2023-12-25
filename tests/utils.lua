local M = {}

M.list_contains = function(list, item)
    for _, v in ipairs(list) do
        if v == item then
            return true
        end
    end
    return false
end

return M

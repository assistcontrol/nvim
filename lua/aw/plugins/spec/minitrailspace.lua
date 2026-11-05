if not AW.has('mini.trailspace') then return end

local exclude = {
    diff = true,
    markdown = true,
}

local trail = require('mini.trailspace')

trail.setup {}

AW.autocmd("BufWritePre", function(args)
    if not exclude[vim.bo[args.buf].filetype] then
        trail.trim()
    end
end)

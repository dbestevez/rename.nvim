local M = {}

local config = {
  command = "Rename",
}

local function sibling_files(arglead)
  local current_dir = vim.fn.expand("%:h") .. "/"
  local matches = vim.fn.globpath(current_dir, arglead .. "*", false, true)

  return vim.tbl_map(function(path)
    return vim.fn.fnamemodify(path, ":t")
  end, matches)
end

function M.rename(name, bang)
  local old_file = vim.fn.expand("%:p")
  local current_dir = vim.fn.expand("%:h") .. "/"

  vim.v.errmsg = ""

  vim.cmd(
    "silent! saveas"
      .. (bang and "!" or "")
      .. " "
      .. vim.fn.fnameescape(current_dir .. name)
  )

  if vim.v.errmsg == "" or vim.v.errmsg:match("^E329") then
    local new_file = vim.fn.expand("%:p")

    if new_file ~= old_file and vim.fn.filewritable(new_file) == 1 then
      vim.cmd("silent bwipe! " .. vim.fn.fnameescape(old_file))

      if vim.fn.delete(old_file) ~= 0 then
        vim.notify("Could not delete " .. old_file, vim.log.levels.ERROR)
      end
    end
  else
    vim.notify(vim.v.errmsg, vim.log.levels.ERROR)
  end
end

function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})

  vim.api.nvim_create_user_command(config.command, function(opts)
    M.rename(opts.args, opts.bang)
  end, {
    nargs = "*",
    bang = true,
    complete = sibling_files,
    desc = "Rename current file",
  })

  vim.cmd([[
    cabbrev rename <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "Rename" : "rename"<CR>
  ]])
end

return M

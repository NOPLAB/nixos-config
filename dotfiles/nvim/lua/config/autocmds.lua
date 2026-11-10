local group = vim.api.nvim_create_augroup("Setup", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained", "BufEnter" }, {
  group = group,
  command = "checktime",
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "lua",
  callback = function(event)
    vim.bo[event.buf].expandtab = true
    vim.bo[event.buf].tabstop = 2
    vim.bo[event.buf].softtabstop = 2
    vim.bo[event.buf].shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd("RecordingEnter", {
  group = group,
  callback = function()
    if vim.fn.reg_recording() ~= "q" then
      vim.cmd("normal! q")
      return
    end

    local recording_group = vim.api.nvim_create_augroup("SetupRecording", { clear = true })
    local buffer = vim.api.nvim_get_current_buf()
    vim.keymap.set("n", "q", "q", { nowait = true, buffer = buffer })
    vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
      once = true,
      group = recording_group,
      callback = function()
        vim.cmd("normal! q")
        vim.notify("stop recording", vim.log.levels.INFO)
      end,
    })
    vim.api.nvim_create_autocmd("RecordingLeave", {
      once = true,
      group = group,
      callback = function()
        vim.keymap.del("n", "q", { buffer = buffer })
        vim.api.nvim_del_augroup_by_id(recording_group)
      end,
    })
  end,
})

local ok, _ = pcall(require, "plenary")
if not ok then
  vim.api.nvim_err_writeln "plenary.nvim not found"
  return
end

local Job = require "plenary.job"
---@param args string[]
---@param opts? table
---@return string[]
local git_command = function(args, opts)
  opts = opts or {}

  local _args = { "git" }
  if opts.git_dir then
    vim.list_extend(_args, { "--git-dir", opts.git_dir })
  end
  return vim.list_extend(_args, args)
end

---@param cmd string[]
---@param cwd? string
---@return table|nil, integer, string[]
local get_os_cmd_output = function(cmd, cwd)
  assert(type(cmd) == "table", "cmd must be a table")
  assert(cwd ~= nil, "cwd must be provided")
  local command = table.remove(cmd, 1)
  local stderr = {}
---@diagnostic disable-next-line: missing-fields
  local stdout, ret = Job:new({
    command = command,
    args = cmd,
    cwd = cwd,
    on_stderr = function(_, data)
      table.insert(stderr, data)
    end,
  }):sync()
  return stdout, ret, stderr
end

---@param args string[]
---@param opts? table
---@return table|nil, integer, string[]
local get_git_cmd_output = function(args, opts)
  assert(type(args) == "table", "args must be a table")
  assert(opts ~= nil, "opts must be provided")
  local cmd = git_command(args, opts)
  return get_os_cmd_output(cmd, opts.cwd)
end

---@param opts? table
local get_git_branches = function(opts)
  assert(opts ~= nil, "opts must be provided")
  local format = "%(HEAD)" .. "%(refname)"

  local output = get_git_cmd_output({
    "for-each-ref",
    "--perl",
    "--format",
    format,
    "--sort",
    "-authordate",
    opts.pattern,
  }, opts)
  assert(output ~= nil, "output must be provided")

  local show_remote_tracking_branches =
    vim.F.if_nil(opts.show_remote_tracking_branches, true)

  local unescape_single_quote = function(v)
    return string.gsub(v, "\\([\\'])", "%1")
  end

  local parse_line = function(line)
    local fields = vim.split(string.sub(line, 2, -2), "''")
    local entry = {
      head = fields[1],
      refname = unescape_single_quote(fields[2]),
    }
    local prefix
    if vim.startswith(entry.refname, "refs/remotes/") then
      if show_remote_tracking_branches then
        prefix = "refs/remotes/"
      else
        return
      end
    elseif vim.startswith(entry.refname, "refs/heads/") then
      prefix = "refs/heads/"
    else
      return
    end
    if entry.head == "*" then
      entry.name = string.sub(entry.refname, string.len(prefix) + 1)
    end

    if entry.name ~= nil then
      return entry
    else
      return nil
    end
  end
  for _, line in ipairs(output) do
    local entry = parse_line(line)
    if entry ~= nil then
      return entry
    end
  end
  return nil
end

local current_branch = get_git_branches {
  cwd = vim.uv.cwd(),
  show_remote_tracking_branches = true,
}

assert(current_branch ~= nil, "current_branch is nil")

---@param feature string
---@param insert_end? boolean
local insert_feature_branch = function(feature, insert_end)
  assert(feature ~= nil, "feature must be provided")
  if insert_end == nil then
    insert_end = false
  end
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  lines[1] = feature
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.api.nvim_win_set_cursor(0, { 1, 0 })
  if insert_end then
    vim.api.nvim_feedkeys("A", "n", false)
  else
    vim.api.nvim_feedkeys("I", "n", false)
  end
end

---@param type "Jira"|"conventional-commits"
---@param branch string
local insert_commit_format = function(type, branch)
  local feature = branch
  if branch:find "feature/" then
    feature = vim.split(branch, "/")[2]
  end
  if type == "Jira" then
    insert_feature_branch(string.format("[%s]", feature))
  elseif type == "conventional-commits" then
    vim.ui.select({
      "feat",
      "fix",
      "chore",
      "docs",
      "style",
      "refactor",
      "perf",
      "test",
      "build",
      "ci",
      "revert",
    }, {
      prompt = "Select the type of commit",
    }, function(choice)
      vim.ui.input({
        prompt = "Enter the scope (empty for feature/<feature>)",
      }, function(input)
        if input == nil or input == "" then
          input = string.format("(%s):", feature)
        else
          input = string.format("(%s):", input)
        end
        insert_feature_branch(string.format("%s%s", choice, input), true)
      end)
    end)
  elseif type == "none" then
    insert_feature_branch ""
  end
end

if
  current_branch.name ~= nil
then
  vim.ui.select({
    "Jira",
    "conventional-commits",
    "none",
  }, {
    prompt = "Select the type of commit",
  }, function(choice)
    insert_commit_format(choice, current_branch.name)
  end)
end

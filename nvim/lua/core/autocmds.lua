local api     = vim.api
local map     = require("core.utils").uniqueKeymap
local augroup = api.nvim_create_augroup
local fn      = vim.fn
local o       = vim.o
local wo      = vim.wo
local g       = vim.g

------------------------------------------------------------------------------------------------------------------------
-- AUTO-CD TO PROJECT ROOT

--[[ AUTO CD TO PROJECT ROOT
local autoCdConfig = {
        childOfRoot = {
                ".git",
        },
        parentOfRoot = {
                ".config",
                vim.fs.basename(vim.env.HOME),
        },
}
api.nvim_create_autocmd("VimEnter", {
        desc     = "User: Auto-cd to project root",
        callback = function(ctx)
                local root = vim.fs.root(ctx.buf, function(name, path)
                        local parentName         = vim.fs.basename(vim.fs.dirname(path))
                        local dirHasParentMarker = vim.tbl_contains(autoCdConfig.parentOfRoot, parentName)
                        local dirHasChildMarker  = vim.tbl_contains(autoCdConfig.childOfRoot, name)
                        return dirHasChildMarker or dirHasParentMarker
                end)
                if root and root ~= "" then vim.uv.chdir(root) end
        end,
})
--]]

------------------------------------------------------------------------------------------------------------------------
-- <q>

api.nvim_create_autocmd("FileType", {
        group    = augroup("Close with <q>", { clear = true }),
        pattern  = {
                "PlenaryTestPopup",
                "help",
                "lspinfo",
                "man",
                "notify",
                "qf",
                "spectre_panel",
                "startuptime",
                "tsplayground",
                "neotest-output",
                "checkhealth",
                "neotest-summary",
                "neotest-output-panel",
        },
        callback = function(event)
                vim.bo[event.buf].buflisted = false
                vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
        end,
})

------------------------------------------------------------------------------------------------------------------------

api.nvim_create_autocmd("FocusGained", {
        desc     = "User: FIX `cwd` being not available when it is deleted outside nvim.",
        callback = function()
                ---@diagnostic disable-next-line: undefined-field
                if not vim.uv.cwd() then vim.uv.chdir("/") end
        end,
})

api.nvim_create_autocmd("FocusGained", {
        desc     = "User: Close all non-existing buffers on `FocusGained`.",
        callback = function()
                local closedBuffers = {}
                local allBufs       = fn.getbufinfo{ buflisted = 1 }
                vim.iter(allBufs):each(function(buf)
                        if not api.nvim_buf_is_valid(buf.bufnr) then return end
                        ---@diagnostic disable-next-line: undefined-field
                        local stillExists   = vim.uv.fs_stat(buf.name) ~= nil
                        local specialBuffer = vim.bo[buf.bufnr].buftype ~= ""
                        local newBuffer     = buf.name == ""
                        if stillExists or specialBuffer or newBuffer then return end
                        table.insert(closedBuffers, vim.fs.basename(buf.name))
                        api.nvim_buf_delete(buf.bufnr, { force = false })
                end)
                if #closedBuffers == 0 then return end

                if #closedBuffers == 1 then
                        vim.notify(closedBuffers[1], nil, { title = "Buffer closed", icon = "󰅗" })
                else
                        local text = "- " .. table.concat(closedBuffers, "\n- ")
                        vim.notify(text, nil, { title = "Buffers closed", icon = "󰅗" })
                end

                -- If ending up in empty buffer, re-open the first oldfile that exists
                vim.defer_fn(function()
                                     if api.nvim_buf_get_name(0) ~= "" then return end
                                     for _, file in ipairs(vim.v.oldfiles) do
                                             ---@diagnostic disable-next-line: undefined-field
                                             if vim.uv.fs_stat(file) and vim.fs.basename(file) ~= "COMMIT_EDITMSG" then
                                                     vim.cmd.edit(file)
                                                     return
                                             end
                                     end
                             end, 1)
        end,
})

------------------------------------------------------------------------------------------------------------------------
-- AUTO-NOHL & INLINE SEARCH COUNT

---@param mode? "clear"
local function searchCountIndicator(mode)
        local signColumnPlusScrollbarWidth = 2 + 3

        local countNs                      = api.nvim_create_namespace("searchCounter")
        api.nvim_buf_clear_namespace(0, countNs, 0, -1)
        if mode == "clear" then return end

        local row   = api.nvim_win_get_cursor(0)[1]
        local count = fn.searchcount()
        if count.total == 0 then return end
        local text     = (" %d/%d "):format(count.current, count.total)
        local line     = api.nvim_get_current_line():gsub("\t", (" "):rep(vim.bo.shiftwidth))
        local lineFull = #line + signColumnPlusScrollbarWidth >= api.nvim_win_get_width(0)
        local margin   = { (" "):rep(lineFull and signColumnPlusScrollbarWidth or 0) }

        ---@diagnostic disable-next-line: unknown-diag-code
        ---@diagnostic disable-next-line: param-type-not-match
        api.nvim_buf_set_extmark(0, countNs, row --[[@cast -?]] - 1, 0, {
                virt_text     = { { text, "IncSearch" }, margin },
                virt_text_pos = lineFull and "right_align" or "eol",
                priority      = 200,
        })
end

-- without the `searchCountIndicator`, this `on_key` simply does `auto-nohl`
vim.on_key(function(key, _typed)
                   key                   = fn.keytrans(key)
                   local isCmdlineSearch = fn.getcmdtype():find("[/?]") ~= nil
                   local isNormalMode    = api.nvim_get_mode().mode == "n"
                   local searchStarted   = (key == "/" or key == "?") and isNormalMode
                   local searchConfirmed = (key == "<CR>" and isCmdlineSearch)
                   local searchCancelled = (key == "<Esc>" and isCmdlineSearch)
                   if not (searchStarted or searchConfirmed or searchCancelled or isNormalMode) then return end

                   -- works for RHS, therefore no need to consider remaps
                   local searchMovement = vim.tbl_contains({ "n", "N", "*", "#" }, key)
                   local shortPattern   = fn.getreg("/"):gsub([[\V\C]], ""):len() <= 1 -- for `fF` function

                   if searchCancelled or (not searchMovement and not searchConfirmed) then
                           vim.opt.hlsearch = false
                           searchCountIndicator("clear")
                   elseif (searchMovement and not shortPattern) or searchConfirmed or searchStarted then
                           vim.opt.hlsearch = true
                           vim.defer_fn(searchCountIndicator, 1)
                   end
           end, api.nvim_create_namespace("autoNohlAndSearchCount"))

------------------------------------------------------------------------------------------------------------------------
-- SKELETONS (TEMPLATES)

-- CONFIG
local templateDir       = fn.stdpath("config") .. "/templates"
local globToTemplateMap = {
        [g.localRepos .. "/**/*.lua"]                    = "module.lua",
        [fn.stdpath("config") .. "/lua/functions/*.lua"] = "module.lua",
        [fn.stdpath("config") .. "/lua/plugins/*.lua"]   = "plugin-spec.lua",
        [fn.stdpath("config") .. "/lsp/*.lua"]           = "lsp.lua",

        -- ["**/*.py"]                                          = "template.py",
        ["**/*.sh"]                                      = "template.zsh",
        ["**/*.*sh"]                                     = "template.zsh",
}

---@diagnostic disable-next-line: need-check-nil
api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
        desc     = "User: Apply templates (`BufReadPost` for files created outside of nvim.)",
        callback = function(ctx)
                vim.defer_fn(
                ---@diagnostic disable-next-line: undefined-field
                        function()
                                ---@diagnostic disable-next-line: undefined-field
                                -- defer, to ensure new files are written
                                local stats = vim.uv.fs_stat(ctx.file)
                                if not stats or stats.size > 10 then return end -- 10 bytes for file metadata
                                local filepath, bufnr = ctx.file, ctx.buf

                                -- determine template from glob
                                local matchedGlob = vim.iter(globToTemplateMap):find(function(glob)
                                        local globMatchesFilename = vim.glob.to_lpeg(glob):match(filepath)
                                        return globMatchesFilename
                                end)
                                if not matchedGlob then return end
                                local templateFile = globToTemplateMap[matchedGlob]
                                local templatePath = vim.fs.normalize(templateDir .. "/" .. templateFile)
                                ---@diagnostic disable-next-line: undefined-field
                                if not vim.uv.fs_stat(templatePath) then return end

                                -- read template & move to cursor placeholder
                                local content = {}
                                local cursor
                                local row = 1
                                for line in io.lines(templatePath) do
                                        local placeholderPos = line:find("%$0")
                                        if placeholderPos then
                                                line = line:gsub("%$0", "")
                                                cursor = { row, placeholderPos - 1 }
                                        end
                                        table.insert(content, line)
                                        row = row + 1
                                end
                                api.nvim_buf_set_lines(0, 0, -1, false, content)
                                ---@diagnostic disable-next-line: unknown-diag-code
                                ---@diagnostic disable-next-line: unnecessary-if
                                if cursor then api.nvim_win_set_cursor(0, cursor) end

                                -- adjust filetype if needed (e.g. when applying a zsh template to .sh files)
                                local newFt = vim.filetype.match{ buf = bufnr }
                                ---@diagnostic disable-next-line: assign-type-mismatch
                                if vim.bo[bufnr].ft ~= newFt then vim.bo[bufnr].ft = newFt end
                        end, 100)
        end,
})

------------------------------------------------------------------------------------------------------------------------
-- ENFORCE SCROLLOFF AT EOF

api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "WinScrolled" }, {
        desc = "Fix scrolloff when you are at the EOF",
        group = augroup("ScrollEOF", { clear = true }),
        callback = function()
                if api.nvim_win_get_config(0).relative ~= "" then
                        return -- Ignore floating windows
                end

                local win_height = fn.winheight(0)
                local scrolloff = math.min(o.scrolloff, math.floor(win_height / 2))
                local visual_distance_to_eof = win_height - fn.winline()

                if visual_distance_to_eof < scrolloff then
                        local win_view = fn.winsaveview()
                        fn.winrestview({ topline = win_view.topline + scrolloff - visual_distance_to_eof })
                end
        end,
})

-- FIX: for some reason `scrolloff` sometimes being set to `0` on new buffers
local originalScrolloff = o.scrolloff
api.nvim_create_autocmd({ "BufReadPost", "BufNew" }, {
        desc     = "User: FIX scrolloff on entering new buffer",
        callback = function(ctx)
                vim.defer_fn(function()
                                     if not api.nvim_buf_is_valid(ctx.buf) or vim.bo[ctx.buf].buftype ~= "" then return end
                                     ---@diagnostic disable-next-line: unknown-diag-code
                                     ---@diagnostic disable-next-line: preferred-local-alias
                                     if vim.o.scrolloff == 0 then
                                             o.scrolloff = originalScrolloff
                                             vim.notify("Triggered by [" .. ctx.event .. "]", nil,
                                                        { title = "Scrolloff fix" })
                                     end
                             end, 150)
        end,
})

------------------------------------------------------------------------------------------------------------------------
-- STAY IN CMD

api.nvim_create_autocmd("CmdwinEnter", {
        desc     = "Execute command and stay in the command-line window",
        group    = augroup("mariasolos/execute_cmd_and_stay", { clear = true }),
        callback = function(args)
                vim.keymap.set({ "n", "i" }, "<S-CR>", "<cr>q:", { buffer = args.buf })
        end,
})

------------------------------------------------------------------------------------------------------------------------
-- LSP

api.nvim_create_autocmd("LspAttach", {
        group    = augroup("lsp-attach", { clear = true }),
        callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                local lsp    = vim.lsp
                local buf    = args.buf
                local mode   = fn.mode()

                --------------------------------------------------------------------------------------------------------
                -- DOCUMENT HIGHLIGHTING

                ---@diagnostic disable-next-line: unknown-diag-code
                ---@diagnostic disable-next-line: unnecessary-if
                -- if fn.has("nvim-0.11") == 1 and client:supports_method("textDocument/documentHighlight") then
                if fn.has("nvim-0.11") == 1 and client.server_capabilities.documentHighlightProvider then
                        local highlight_augroup = augroup("lsp-highlight", { clear = false })

                        api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                                buffer   = buf,
                                group    = highlight_augroup,
                                callback = lsp.buf.document_highlight,
                        })

                        api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                                buffer   = buf,
                                group    = highlight_augroup,
                                callback = lsp.buf.clear_references,
                        })

                        api.nvim_create_autocmd("LspDetach", {
                                group    = augroup("lsp-detach", { clear = true }),
                                ---@diagnostic disable-next-line: unknown-diag-code
                                ---@diagnostic disable-next-line: unused
                                callback = function(event2)
                                        lsp.buf.clear_references()
                                        -- api.nvim_clear_autocmd({ "lsp-highlight", buffer = event2.buf })
                                end,
                        })
                end

                --------------------------------------------------------------------------------------------------------
                -- INLAY HINTS

                if fn.has("nvim-0.10") == 1 and client.server_capabilities.inlayHintProvider and lsp.inlay_hint then
                        lsp.inlay_hint.enable(true, nil)
                elseif mode ~= "n" then
                        lsp.inlay_hint.enable(false, nil)
                end

                --------------------------------------------------------------------------------------------------------
                -- CODELENS

                --[[
                map("n", "<leader>oh",
                    function() lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf }) end,
                    { buffer = buf, desc = "Toggle Inlay Hints" }
                )
                --]]
        end,
})

------------------------------------------------------------------------------------------------------------------------
-- SMART VIRTUAL EDITING

api.nvim_create_autocmd("ModeChanged", {
        pattern  = "*:*",
        callback = function()
                local mode = fn.mode()
                if mode == "n" or mode == "\22" then vim.opt.virtualedit = "all" end
                if mode == "i" then vim.opt.virtualedit = "block" end
                if mode == "v" or mode == "V" then vim.opt.virtualedit = "onemore" end
        end,
})

------------------------------------------------------------------------------------------------------------------------
-- SWITCH BETWEEN `rlnu` and `lnu`

api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
        pattern  = "*",
        callback = function()
                if wo.number and api.nvim_get_mode().mode ~= "i" then
                        wo.relativenumber = true
                        wo.signcolumn     = "yes"
                        -- wo.foldcolumn     = "1"
                end
        end,
})

api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
        pattern  = "*",
        callback = function()
                if wo.number then
                        wo.relativenumber = false
                        wo.signcolumn     = "no"
                        wo.foldcolumn     = "0"
                        -- vim.cmd("redraw!")
                end
        end,
})

------------------------------------------------------------------------------------------------------------------------
-- RESTORE CURSOR POSITION

api.nvim_create_autocmd({ "BufReadPost", "BufReadPre", "BufWinEnter" }, {
        desc     = "Restore cursor position",
        pattern  = "*",
        callback = function(args)
                local mark       = api.nvim_buf_get_mark(args.buf, '"')
                local line_count = api.nvim_buf_line_count(args.buf)
                if mark[1] > 0 and mark[1] <= line_count then
                        api.nvim_buf_call(args.buf, function() vim.cmd('normal! g`"zz') end)
                end
        end,
})

------------------------------------------------------------------------------------------------------------------------
-- CLEAR TRAILING WHITESPACE

api.nvim_create_autocmd({ "BufWritePre" }, {
        desc     = "Remove trailing whitespace",
        pattern  = "*",
        callback = function() vim.cmd([[%s/\s\+$//e]]) end,
})

------------------------------------------------------------------------------------------------------------------------
-- SPLITS

api.nvim_create_autocmd("FileType", {
        desc    = "Automatically split help buffers to the right",
        pattern = "help",
        command = "wincmd L",
})

api.nvim_create_autocmd("VimResized", {
        desc = "Automatically resize splits, when terminal window is moved",
        command = "wincmd =",
})

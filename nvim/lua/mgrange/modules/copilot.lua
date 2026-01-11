require('fzf-lua').register_ui_select()

return 
{
    {
        "github/copilot.vim",
        event = "VimEnter",
        config = function()
            -- Disable default tab completion to avoid conflicts with nvim-cmp
            vim.g.copilot_no_tab_map = true
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = 
        {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
        opts =
        {
            model = 'claude-3-5-sonnet-20241022',
            temperature = 0.1,           -- Lower = focused, higher = creative
            window =
            {
                layout = 'float',
                width = 0.8, -- 80% of editor width
                height = 0.8, -- 80% of editor height
                border = 'rounded', -- 'single', 'double', 'rounded', 'solid'
                title = '🤖 AI Assistant',
                zindex = 100, -- Ensure window stays on top
            },

            headers = 
            {
                user = '👤 You',
                assistant = '🤖 Copilot',
                tool = '🔧 Tool',
            },

            separator = '━━',
            auto_fold = true, -- Automatically folds non-assistant messages
        },
    },
}
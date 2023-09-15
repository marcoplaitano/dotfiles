-- Boostrap Packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
local packer_bootstrap
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
end

-- Load Packer
vim.cmd([[packadd packer.nvim]])

-- Rerun PackerCompile everytime plugins.lua is updated
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])


local status, packer = pcall(require, "packer")
if not status then
    return
end

-- Configuration.
packer.init {
    ensure_dependencies = true,
    auto_clean = true,
    compile_on_sync = true,
    auto_reload_compiled = true,
    display = {
        -- Make packer appear in popup window.
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
        compact = true,
    },
}

return packer.startup(function(use)
    -- To update packer itself.
    use({ "wbthomason/packer.nvim", opt = true })

    -- Icons, used by many other packages.
    use "nvim-tree/nvim-web-devicons"

    -- Show git signs of lines added/modified/deleted, in the signcolumn.
    use "airblade/vim-gitgutter"

    -- Show preview of hex color.
    use "ap/vim-css-color"

    -- Autopairs.
    use "windwp/nvim-autopairs"

    -- Telescope.
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.1",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    -- Tree file navigation.
    use "nvim-lua/plenary.nvim"
    use "MunifTanjim/nui.nvim"
    use { "nvim-neo-tree/neo-tree.nvim", as = "neotree" }

    -- Welcome page dashboard.
    use { "goolord/alpha-nvim", lazy = true }

    -- Commenter.
    use { "preservim/nerdcommenter", as = "commenter" }

    -- Language servers.
    use { "williamboman/mason.nvim", run = ":MasonUpdate" }
    use "williamboman/mason-lspconfig.nvim"
    use "neovim/nvim-lspconfig"

    -- Auto completion.
    use {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "f3fora/cmp-spell",
        "L3MON4D3/LuaSnip",
    }

    -- Syntax highlighting.
    use {
        "nvim-treesitter/nvim-treesitter",
        as = "treesitter",
        run = function()
            require("treesitter.install").update({ with_sync = true })
        end,
    }

    -- Status line.
    use "nvim-lualine/lualine.nvim"

    -- Colorschemes.
    use "projekt0n/github-nvim-theme"
    use "Mofiqul/vscode.nvim"
    use { "catppuccin/nvim", as = "catppuccin" }
    use 'shaunsingh/nord.nvim'
    use 'navarasu/onedark.nvim'

    if packer_bootstrap then
        require("packer").sync()
    end
end)

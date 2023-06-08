{ pkgs, lib, buildVimPluginFrom2Nix, buildNeovimPluginFrom2Nix, vimUtils, fetchFromGitHub, ... }:

let
  ghtheme = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "ghtheme";
    version = "";
    src = pkgs.fetchFromGitHub {
      owner = "projekt0n";
      repo = "github-nvim-theme";
      rev = "62b7b54a90c70c20cd1641f9facfced46bdd3561";
      sha256 = "sha256-1eZvTqdRvol85xgoh9anMjj9ovb34F391HtYl71+IDA=";
    };
  };
in {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      rust-tools-nvim
      haskell-vim
      vim-markdown
      ale
      ghtheme
    ];
    coc = {
      enable = true;
      # Haskell
      settings.languageserver.haskell = {
        command = "haskell-language-server-wrapper";
        args = [ "--lsp" ];
        rootPaterns= [
          "*.cabal"
          "cabal.project"
          "hie.yaml"
          "stack.yaml"
          "package.yaml"
        ];
        filetypes = [ "haskell" "lhaskell" ];
      };

      # Rust
      settings.languageserver.rust = {
        command = "rust-analyser";
        args = [ ];
        rootPaterns = [
          "Cargo.lock"
          "Cargo.toml"
        ];
        filetypes = [ "rust" ];
      };
    };
    extraPackages = with pkgs; [
      nodejs
      rust-analyzer 
    ];
    defaultEditor = true;
    withNodeJs = true;
    extraLuaConfig = ''
      -- require('github-theme').setup({})
      vim.cmd('colorscheme github_dark_high_contrast')
      -- vim.cmd('colorscheme github_dark_dimmed')
      -- vim.cmd('colorscheme github_dark_colorbind')
      -- vim.cmd('colorscheme github_dark_tritanopia')
      -- vim.cmd('colorscheme github_light_tritanopia')

      vim.o.shiftwidth = 4
      vim.o.tabstop = 4
      vim.o.expandtab = true
      vim.o.hlsearch = true
      vim.o.incsearch = true
      
      vim.api.nvim_set_keymap('n', ',', ':Explore<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', ';', ':Rex<CR>', { noremap = true })
      vim.cmd('syntax enable')
      vim.cmd('syntax on')
      
      vim.o.encoding = 'utf-8'
      vim.o.fileencoding = 'utf-8'
      vim.o.scrolloff = 10
      vim.o.wrap = false
      vim.o.showcmd = true
      vim.o.showmode = true
      vim.o.showmatch = true
      vim.o.nocompatible = true
      vim.o.number = true
      
      vim.o.backup = false
      vim.o.swapfile = false
      vim.o.undofile = false
      vim.o.backupcopy = 'no'
    '';
  };
}

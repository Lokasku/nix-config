{ pkgs, lib,  ... }:

let
  photon = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "photon";
    version = "";
    src = pkgs.fetchFromGitHub {
      owner = "axvr";
      repo = "photon.vim";
      rev = "32b42c8a12bf9588259b76f3df6807960e0d7386";
      sha256 = "sha256-kM7WP03uE20yr0nCusB3ncHzgtEYxqNzoNoQGen9p+o=";
    };
  };
in {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      rust-tools-nvim
      haskell-vim
      vim-markdown
      ale
      photon
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
      vim.cmd('colorscheme photon')

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

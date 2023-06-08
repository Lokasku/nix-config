{ pkgs, lib, ... }:

with lib;
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-tree-lua
      rust-tools-nvim
      haskell-vim
      vim-markdown
      ale
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
    extraPackages = [
      pkgs.nodejs
    ];
    defaultEditor = true;
    extraConfig = ''
      set nobackup
      set number

      nnoremap , :Explore<CR>
      nnoremap ; :Rex<CR>
    '';
    withNodeJs = true;
  };
}

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
  komau = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "komau";
    version = "";
    src = pkgs.fetchFromGitHub {
      owner = "ntk148v";
      repo = "komau.vim";
      rev = "759adf8a6b3daa57c5f9229e241968e401e4ac4c";
      sha256 = "sha256-veKyXZ4wh+02tOyKRFP5l137wQoTNXcJqPhCPS3E5jA=";
    };
  };
  quantum = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "quantum";
    version = "";
    src = pkgs.fetchFromGitHub {
      owner = "kjssad";
      repo = "quantum.vim";
      rev = "32c3eee862eb3d607ec74d7e3e776079d702f8a9";
      sha256 = "sha256-27zPQB1m3J7Ue8xMIIRSautAi3+CvKVrideaAb2DC+M=";
    };
  };

in {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      rust-tools-nvim
      photon
      # komau
      # quantum

      # LSP (CMP)
      nvim-cmp
      cmp-nvim-lsp
      nvim-lspconfig
      plenary-nvim
      coc-clangd
      vim-vsnip
    ];
    extraPackages = with pkgs; [
      nodejs
      rust-analyzer  
      clojure-lsp
      haskell-language-server
    ];
    withNodeJs = true;
    extraLuaConfig = ''
     local cmp = require('cmp')
     cmp.setup({
       snippet = {
         expand = function(args)
           vim.fn["vsnip#anonymous"](args.body)
         end,
       },
       mapping = {
         ['<C-Space>'] = cmp.mapping.complete(),
         ['<CR>'] = cmp.mapping.confirm({
           behavior = cmp.ConfirmBehavior.Replace,
           select = true,
         }),
       },
       sources = {
         { name = 'nvim_lsp' },
         { name = 'vsnip' },
        },
      })

      local lspconfig = require('lspconfig')

      -- Rust
      lspconfig.rust_analyzer.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      })

      -- Haskell
      lspconfig.hls.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      })

      -- C
      lspconfig.clangd.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      })
      
      -- Clojure
      lspconfig.clojure_lsp.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      })


      -- vim.cmd('colorscheme photon')
      -- vim.cmd('colorscheme komau')
      -- vim.cmd('colorscheme quantum')

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

{ lib, pkgs, ... }:

{
    programs.emacs.extraPackages = epkgs: [
        epkgs.rust-mode
        epkgs.nix-mode
        epkgs.eglot
        epkgs.envrc
        epkgs.projectile
        # epkgs.dired-sidebar

        epkgs.all-the-icons
        epkgs.all-the-icons-dired

        epkgs.ivy
        epkgs.counsel
    ];

    home.file.".emacs.d" = {
        source = ./emacs;
        recursive = true;
    };
}

;; Envrc
(envrc-global-mode)

;; Icons
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; Projectile
(projectile-global-mode)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Display
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)
(setq initial-scratch-message ";; Happy hacking.")

;; Rust
(add-hook 'rust-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)
	    (prettify-symbols-mode)))
(add-hook 'rust-mode-hook 'eglot-ensure)
(setq rust-format-on-save t)

;; Nix
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

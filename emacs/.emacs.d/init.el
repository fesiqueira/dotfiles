;; Enable MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package diminish)


;; # Interface #
;; Remove startup screen
(setq inhibit-startup-screen t)

;; Remove top bars and scroll bar
(tooltip-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 10)

;; highlight current line
(global-hl-line-mode 1)

;; line numbers and make it relative
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
;; (setq-default indicate-empty-lines t)

;; Prevent line wraping
(setq-default truncate-lines t)
(global-visual-line-mode 1)

;; Enable smooth-scrolling
(require 'smooth-scrolling)
(smooth-scrolling-mode t)
(setq smooth-scroll-margin 15)

;; Doom Themes
(use-package doom-themes
  :init (load-theme 'doom-tomorrow-night t))
  ;; :init (load-theme 'doom-solarized-light t))

;; powerline
(use-package powerline)


;; Enable background transparency
;;(set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
;;(set-frame-parameter (selected-frame) 'alpha <both>)
(set-frame-parameter (selected-frame) 'alpha '(95 . 95))

;; Choose font
;;(set-face-attribute 'default nil :font "Liga Meslo" :height 105)
(set-face-attribute 'default nil :font "Ubuntu Mono" :height 125)


;; # Keybindings #
(use-package general
  :config
  (general-create-definer self/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (self/leader-keys
    "p"  '(:ignore p :which-key "project")
    "ps" '(swiper-all :which-key "search in project")
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")))

;; required by evil to enable undo/redo. Can be disabled in Emacs 28
(use-package undo-tree
  :diminish
  :ensure
  :init
  (global-undo-tree-mode))

(use-package evil
  :diminish
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :init
  (evil-collection-init))

(use-package magit
  :ensure t)

;; # QoL #
;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; colorful parens :D
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package counsel
  :diminish
  :after ivy
  :config (counsel-mode))

(use-package ivy
  :demand
  :diminish
  :bind (:map ivy-minibuffer-map
	("C-j" . ivy-next-line)
	("C-k" . ivy-previous-line)
	:map ivy-switch-buffer-map
	("C-k" . ivy-previous-line)
	("C-d" . ivy-switch-buffer-kill)
	:map ivy-reverse-i-search-map
	("C-k" . ivy-previous-line)
	("C-d" . ivy-reverse-i-search-kill))
  :config (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :init (ivy-rich-mode))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)))

;; Buffer switching
(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)

;; Enable autopairs
(electric-pair-mode t)

;; Enable LSP
(require 'lsp-mode)
(add-hook 'go-mode-hook #'lsp)
(add-hook 'typescript-mode-hook #'lsp)

;; Enable flycheck in all buffers
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Enable company-mode in all buffers
(add-hook 'after-init-hook 'global-company-mode)

;; Enable helm
;; (setq helm-mode-fuzzy-match t)
;; (setq completion-styles '(flex))
;; (require 'helm)
;; (helm-mode t)
;; (global-set-key (kbd "M-x") 'helm-M-x)

;; Enable which-key
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))
;; (setq which-key-idle-delay 0.3)
;; (require 'which-key)
;; (which-key-mode t)

;; Sync environment variables
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(use-package helpful
  :custom ((counsel-describe-function-function #'helpful-callable)
	   (counsel-describe-variable-function #'helpful-variable))
  :bind (([remap describe-function] . counsel-describe-function)
	 ([remap describe-command] . helpful-command)
	 ([remap describe-variable] . counsel-describe-variable)
	 ([remap describe-key] . helpful-key)))

(use-package editorconfig
  :ensure t
  :config (editorconfig-mode 1))

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq create-lockfiles nil)

;; (use-package projectile
;;   :diminish
;;   :config (projectile-mode)
;;   :custom ((projectile-completion-system 'ivy))
;;   :init
;;   (when (file-directory-p "~/fun")
;;     (setq projectile-project-search-path '("~/fun")))
;;   (setq projectile-switch-project-action #'projectile-dired))

;; (use-package counsel-projectile
;;   :after projectile
;;   :config (counsel-projectile-mode))
(setq-default indent-tabs-mode nil)

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package all-the-icons)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/fun")
    (setq projectile-project-search-path '("~/fun")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package emojify
  :hook (after-init . global-emojify-mode))

;; # Installed packages #
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e8df30cd7fb42e56a4efc585540a2e63b0c6eeb9f4dc053373e05d774332fc13" "6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" "f8f6d2aac98f8749a3a2a3c9321b9f26e32aef2fc50ec72c4007286ec44f4a2e" "bf798e9e8ff00d4bf2512597f36e5a135ce48e477ce88a0764cfb5d8104e8163" "c9ddf33b383e74dac7690255dd2c3dfa1961a8e8a1d20e401c6572febef61045" "36ca8f60565af20ef4f30783aa16a26d96c02df7b4e54e9900a5138fb33808da" default))
 '(helm-completion-style 'emacs)
 '(helm-minibuffer-history-key "M-p")
 '(package-selected-packages
   '(emojify magit counsel-projectile projectile all-the-icons editorconfig diminish undo-tree general rainbow-delimiters powerline helpful doom-themes ivy use-package typescript-mode flycheck exec-path-from-shell gruvbox-theme hybrid-reverse-theme which-key company lsp-ui go-mode lsp-mode evil-collection smooth-scrolling ample-theme evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

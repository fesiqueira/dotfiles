;; basic configs
;; start in *scratch*
(setq inhibit-startup-screen t)

;; no *scratch* message
(setq initial-scratch-message "")

;; highlight current line
(global-hl-line-mode t)

;; show current column
(column-number-mode t)

;; relative line numbers
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

;; cleanup the interface
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; autoclose brackets, parens and etc
(electric-pair-mode t)

;; fix indentation
(setq-default indent-tabs-mode nil)

;; y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; auto-revert, please
(global-auto-revert-mode t)

;; remove whitespaces
(add-hook 'before-save-hook 'whitespace-cleanup)

;; set background opacity
(set-frame-parameter (selected-frame) 'alpha '(95 . 95))
;; pick a font
(set-face-attribute 'default nil :font "Ubuntu Mono" :height 125)

;; move customize to a separate file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; keep .emacs.d clean
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")
      url-history-file (expand-file-name "url/history" user-emacs-directory))


;; package and stuff (melpa)
(require 'package)

;; install packages in another directory
(setq package-user-dir (expand-file-name "~/.cache/emacs/packages"))

;; append melpa's url to package-archives list
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;; ensure package list is up-to-date
(unless package-archive-contents
  (package-refresh-contents))

;; ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; enable and configure use-package
(require 'use-package)
(setq use-package-always-ensure t)

(use-package diminish)


;; visual packages
;; install doom-themes and pick a theme
(use-package doom-themes
  :diminish
  :init (load-theme 'doom-tomorrow-night t))

;; colorful brackets, parens and etc
(use-package rainbow-delimiters
  :init (rainbow-delimiters-mode))

;; emojis :D
(use-package emojify
  :hook (after-init . global-emojify-mode))

;; not really visual, but smooth scrolling
(use-package smooth-scrolling
  :init (setq smooth-scroll-margin 10)
  :config (smooth-scrolling-mode t))

(use-package powerline
  :config (powerline-center-evil-theme))

;; the good stuff
;; ensure undo and redo functionality in Emacs < 28
(use-package undo-tree
  :diminish
  :init (global-undo-tree-mode))

;; almighty evil-mode
(use-package evil
  :diminish
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-undo-system 'undo-tree)
  (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
  :config (evil-mode t))

;; bunch of evil-mode keybindings
(use-package evil-collection
  :after evil
  :custom
  (evil-collection-setup-minibuffer t)
  (evil-collection-want-unimpaired-p nil)
  :init (evil-collection-init))

;; magit
(use-package magit
  :init
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))

;; sync env variables
(use-package exec-path-from-shell
  :init (exec-path-from-shell-initialize))

;; ivy
(use-package ivy
  :diminish
  :init
  (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
  :config (ivy-mode t))

(use-package ivy-rich
  :diminish
  :after (ivy counsel)
  :config (ivy-rich-mode t))

(use-package counsel
  :diminish
  :after ivy
  :config (counsel-mode t))

(use-package smex
  :after ivy)

;; keep .emacs.d clean
(use-package no-littering)

;; which key?
(use-package which-key
  :diminish
  :config (which-key-mode t))

;; languages
(use-package typescript-mode)

(use-package go-mode)

(use-package lsp-mode
  :hook ((typescript-mode go-mode) . lsp))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode))

(use-package flycheck
  :hook (lsp-mode . flycheck-mode))

(use-package company
  :diminish
  :defer t
  :init (global-company-mode))

;; TODO: check if the following packages/configs are useful
;; - projectile (counsel-projectile?)
;; - helpful
;; - editorconfig
;; - create-lockfile
;; - which-key
;; - general/hydra
;; - set-fringe-mode
;; - all-the-icons

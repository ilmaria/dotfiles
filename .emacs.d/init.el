(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(package-initialize)

;; Disable toolbar
(tool-bar-mode -1)

;; Normal copy and paste
(cua-mode t)
(setq cua-keep-region-after-copy t)

;; Scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil)            ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)                  ;; scroll window under mouse
(setq scroll-step 1)                                ;; keyboard scroll one line at a time

;; Interactively Do Things
(require 'ido)
(ido-mode t)

(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)

;; Disable line wrap
(set-default 'truncate-lines t)

(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-f") 'isearch-forward)

;; Disable tabs
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

;; Save backup files in emacs directory
(setq backup-directory-alist
      `(("." . "~/.emacs.d/backups")))

(custom-set-variables
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (gruvbox-theme dumb-jump))))

(load-theme 'gruvbox-dark-medium t)

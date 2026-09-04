;; -*- lexical-binding: t; -*-

(global-display-line-numbers-mode 1)
(set-frame-font "Consolas" nil t)
(load-theme 'gruvbox t)
(tool-bar-mode -1)
(cua-mode 1)
(setopt cua-prefix-override-inhibit-delay nil)
(setopt cua-keep-region-after-copy t)
(setq ring-bell-function 'ignore)
(desktop-save-mode 1)
(savehist-mode 1)
(setq-default display-line-numbers-width 3)
(setq enable-recursive-minibuffers t)
(setopt dired-auto-revert-buffer t)
(setopt isearch-repeat-on-direction-change t)
(setopt isearch-wrap-pause 'no)
(setopt shell-command-prompt-show-cwd t)
(setopt compilation-scroll-output 'first-error)
(setopt global-xref-mouse-mode t)
;; Hide commands in M-x which do not work in the current mode.
(setq read-extended-command-predicate #'command-completion-default-include-p)

;; Scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil)            ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)                  ;; scroll window under mouse
(setq scroll-step 1)                                ;; keyboard scroll one line at a time

(setq default-frame-alist
      '((width . 200)
        (height . 60)))

;; Make dired open folders in the same window
(use-package dired
  :bind (:map dired-mode-map
              ([mouse-2] . dired-mouse-find-file)))

(use-package vundo
  :commands (vundo))

(use-package vertico
  :functions vertico-mode
  :init
  (vertico-mode))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil) ;; Disable defaults, use our settings
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

(use-package marginalia
  :functions marginalia-mode
  :init
  (marginalia-mode))

(use-package corfu
  :functions global-corfu-mode corfu-mouse-mode corfu-quit corfu-popupinfo-mode
             corfu-echo-mode
  :defines corfu-mode-map
  :custom
  (corfu-auto t)
  (corfu-quit-no-match t)
  :init
  (global-corfu-mode)
  (keymap-set corfu-mode-map "<escape>" #'corfu-quit)
  (corfu-mouse-mode)
  (corfu-echo-mode)
  (corfu-popupinfo-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(## consult corfu gruvbox-theme marginalia orderless vertico vundo)))

(use-package emacs
  :custom
  (tab-always-indent 'complete)
  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  (text-mode-ispell-word-completion nil)
  ;; Hide commands in M-x which do not apply to the current mode.
  (read-extended-command-predicate #'command-completion-default-include-p))

(global-set-key (kbd "M-<left>") 'previous-buffer)
(global-set-key (kbd "M-<right>") 'next-buffer)

(defun unpop-global-mark ()
  "Unpop off global mark ring and jump to the top location."
  (interactive)
  ;; Pop entries that refer to non-existent buffers.
  (while (and global-mark-ring (not (marker-buffer (car global-mark-ring))))
    (setq global-mark-ring (cdr global-mark-ring)))
  (or global-mark-ring
      (error "No global mark set"))
  (let* ((marker (car (last global-mark-ring)))
	 (buffer (marker-buffer marker))
	 (position (marker-position marker)))
    (setq global-mark-ring
          (cons (car (last global-mark-ring))
                (nbutlast global-mark-ring)))
    (set-buffer buffer)
    (or (and (>= position (point-min))
	     (<= position (point-max)))
	(if widen-automatically
	    (widen)
	  (error "Global mark position is outside accessible part of buffer %s"
                 (buffer-name buffer))))
    (goto-char position)
    (switch-to-buffer buffer)))

;(keymap-global-set "<mouse-4>" #'pop-global-mark)
;(keymap-global-set "<mouse-5>" #'unpop-global-mark)

(keymap-global-set "<mouse-4>" #'xref-go-back)
(keymap-global-set "<mouse-5>" #'xref-go-forward)

(defun my-xref-find-definitions-at-mouse (event)
  "Go to mouse click location and run `xref-find-definitions` with EVENT."
  (interactive "e")
  (mouse-set-point event)
  (let ((id (xref-backend-identifier-at-point (xref-find-backend))))
    (if id
        (xref-find-definitions id))))

(keymap-global-set "<mouse-2>" #'my-xref-find-definitions-at-mouse)

(keymap-set minibuffer-local-map "<escape>" #'keyboard-escape-quit)

(keymap-global-set "C-s" #'save-buffer)
(keymap-global-set "C-w" #'delete-window)
(keymap-global-set "C-f" #'isearch-forward)
(keymap-set isearch-mode-map "<return>" #'isearch-repeat-forward)
(keymap-set isearch-mode-map "S-<return>" #'isearch-repeat-backward)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Indent with spaces
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

(when (eq system-type 'windows-nt)
  (setq backup-directory-alist '(("." . (substitute-in-file-name "$Temp\\emacs-backups"))))
)

(defun mark-current-line ()
  "Select the current line."
  (push-mark (line-beginning-position) nil nil)
  (goto-char (min (1+ (line-end-position)) (point-max))))

(autoload 'cua-cut-region "cua-base" nil t)
(defun cut-line-or-region (arg)
  "Cut region, or whole line if no region."
  (interactive "P")
  (if (not (use-region-p))
      (mark-current-line))
  (cua-cut-region arg))

(autoload 'cua-copy-region "cua-base" nil t)
(defun copy-line-or-region (arg)
  "Copy region, or whole line if no region."
  (interactive "P")
  (if (use-region-p)
      (cua-copy-region arg)
    (save-mark-and-excursion
      (mark-current-line)
      (cua-copy-region arg))))

(autoload 'cua-paste "cua-base" nil t)
(defun my-paste (arg)
  "Paste last cut."
  (interactive "P")
  (if (not (use-region-p))
      (progn (move-beginning-of-line 1)
             (open-line 1)))
  (cua-paste arg))

(defvar cua--cua-keys-keymap)
(defvar cua--prefix-override-keymap)
(with-eval-after-load 'cua-base
  (define-key cua--cua-keys-keymap        [(control x)] #'cut-line-or-region)
  (define-key cua--prefix-override-keymap [(control x)] #'cut-line-or-region)
  (define-key cua--cua-keys-keymap [(control c)] #'copy-line-or-region)
; (define-key cua--cua-keys-keymap        [(control v)] #'my-paste)
; (define-key cua--prefix-override-keymap [(control v)] #'my-paste)
  )

(keymap-global-set "C-SPC" ctl-x-map)

(keymap-global-set "C-z" #'undo-only)
(keymap-global-set "C-y"  #'undo-redo)
(keymap-global-set "C-S-z" #'undo-redo)

(add-hook 'prog-mode-hook 'flymake-mode)

;; Disable bidi stuff for performance
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)
;; Delay syntax highlighting of input text for performance
(setq redisplay-skip-fontification-on-input t)
(setq read-process-output-max (* 4 1024 1024)) ; 4MB


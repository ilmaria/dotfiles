;; -*- lexical-binding: t; -*-

(global-display-line-numbers-mode 1)
(set-frame-font "Consolas" nil t)
(load-theme 'gruvbox t)
(tool-bar-mode -1)
(cua-mode 1)
(setq cua-keep-region-after-copy t)
(setq ring-bell-function 'ignore)

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(gruvbox-theme vertico)))

(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)

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
  "Go to mouse click location and run `xref-find-definitions` (like M-.)."
  (interactive "e")
  (mouse-set-point event)
  (let ((id (xref-backend-identifier-at-point (xref-find-backend))))
    (if id
        (xref-find-definitions id)
      (call-interactively #'xref-find-definitions))))

(keymap-global-set "<mouse-2>" #'my-xref-find-definitions-at-mouse)

(define-key minibuffer-local-map (kbd "ESC") 'keyboard-escape-quit)

(keymap-global-set "C-s" #'save-buffer)
(keymap-global-set "C-w" #'delete-window)
(keymap-global-set "C-f" 'isearch-forward)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Indent with spaces
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

;;; package --- summary  -*- mode: emacs-lisp -*-
;;; .emacs.min --- minimal emacs config

;;; Commentary:
;;
;; run Emacs as
;; \emacs -nw -q --load ~/.emacs.min

;;; Code:

;; disable start-up message
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message "colinxy")

;; version control follow symbolic links
(setq vc-follow-symlinks t)

;; backup files
(setq backup-directory-alist '(("." . "~/.saves"))
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 10
      kept-old-versions 2
      version-control t)

;; substitute y-or-n-p with yes-or-no-p
(defalias 'yes-or-no-p 'y-or-n-p)

;; smooth scrolling
;; keyboard
(setq scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)
;; mouse
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ; one line at a time
;; (setq mouse-wheel-progressive-speed nil) ; don't accelerate scrolling
(setq mouse-wheel-follow-mouse t)       ; scroll window under mouse

;; do not blink cursor
(blink-cursor-mode -1)
;; make cursor blink as few as possible
;; (setq blink-cursor-blinks 1)

;; auto revert
(global-auto-revert-mode)

;; do not indent with tabs
(setq-default indent-tabs-mode nil)
;; (setq-default tab-width 4)
(global-set-key (kbd "RET") 'newline-and-indent)

;; some keys are easy to mispress
(global-unset-key (kbd "C-o"))
(global-unset-key (kbd "C-x C-w"))
;; C-w is only enabled when a region is selected
(defun my-kill-region ()
  "Cuts only when a region is selected."
  (interactive)
  (when mark-active
    (kill-region (region-beginning) (region-end))))
(global-set-key (kbd "C-w") 'my-kill-region)

;; show line number and column number
;; (require 'linum)                       ;line number is broken in emacs
(column-number-mode t)
(show-paren-mode 1)
(when window-system
  (global-hl-line-mode))

;; use DEL to delete selected text
(delete-selection-mode 1)

;; auto insert pair
;; M-( ; insert ()
;; (global-set-key (kbd "M-(") 'insert-pair)
(setq parens-require-spaces nil)
(global-set-key (kbd "M-[") 'insert-pair)  ; insert []
(global-set-key (kbd "M-\"") 'insert-pair) ; insert ""

;; delete trailing white space
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; final newline
(setq require-final-newline t)

(setq split-width-threshold 150) ;split horizontally if at least <> columns

;; no tool bar, no scroll bar
;; function tool-bar-mode, scroll-bar-mode not available without x

;; tango-dark is a good theme
(when (not window-system)
  (menu-bar-mode -1)
  (load-theme 'tango-dark t))

;; c/c++
(setq-default c-basic-offset 4
              c-default-style "k&r")

;; python
(setq-default python-indent-offset 4)


(provide '.emacs.min)
;;; .emacs ends here

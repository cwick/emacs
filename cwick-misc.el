;;;; Miscellaneous tweaks and options that don't fit anywhere else
(delete-selection-mode 1)		; Typed text replaces current selection
(global-linum-mode 1)			; Show line numbers everywhere
(setq linum-eager nil)			; Better linum performance

;; Make sure all backup files only live in one place
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Make apropos find more stuff
(setq apropos-do-all t)

;; Start emacs server
(server-start)

;; Show current column number in modeline
(column-number-mode)

;; Don't prompt when killing a buffer that contains a running process
(remove-hook 'kill-buffer-query-functions 'process-kill-buffer-query-function)

;; Select the help window after invoking help
(setq help-window-select t)

;; Don't show the startup screen
(setq inhibit-startup-message t)

;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Show matching parens
(show-paren-mode t)
(setq show-paren-style 'mixed)

;; Highlight current line everywhere
(global-hl-line-mode t)

;; Display tabs as 4 characters wide
(setq default-tab-width 4)

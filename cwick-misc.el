;;;; Miscellaneous tweaks and options that don't fit anywhere else
(delete-selection-mode 1)		; Typed text replaces current selection

;; Make sure all backup files live in one place
(setq backup-directory-alist '(("." . "~/.emacs.d/data/backups/")))
;; Put autosave files in temp directory
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
;; Save autosave list in data directory
(setq auto-save-list-file-prefix "~/.emacs.d/data/auto-save-list/saves-")

;; Make apropos find more stuff
(setq apropos-do-all t)

;; Start emacs server
(setq server-auth-dir "~/.emacs.d/data/server/")
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

;; Always use UNIX style line endings
(setq default-buffer-file-coding-system 'unix)

;; copy or cut a whole line if there is no region, otherwise, behave as usual
(put 'kill-ring-save 'interactive-form
	 '(interactive
	   (if (use-region-p)
		   (list (region-beginning) (region-end))
		 (list (line-beginning-position) (line-beginning-position 2)))))
(put 'kill-region 'interactive-form
	 '(interactive
	   (if (use-region-p)
		   (list (region-beginning) (region-end))
		 (list (line-beginning-position) (line-beginning-position 2)))))

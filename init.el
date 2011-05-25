;;
;; Zenburn color theme
;;
(add-to-list 'load-path "~/.emacs.d/vendor/zenburn/")
(require 'zenburn-legacy)
(color-theme-zenburn)

;;
;; Things set via the customize command
;;
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(fci-shading ((((class color) (min-colors 88) (background dark)) (:background "gray10"))))
 '(show-paren-match ((t (:background "#7cb8bb" :foreground "#ffffff" :weight bold))))
 '(show-paren-mismatch ((t (:background "#e37170" :foreground "#ffffff" :weight bold)))))

;; Use Consolas on Windows
(if (eq system-type 'windows-nt)
	(set-face-attribute 'default nil
						:slant 'normal 
						:weight 'normal 
						:height 98 
						:width 'normal 
						:foundry "outline" 
						:family "Consolas")
)
;; Use Monaco on OSX
(if (eq system-type 'darwin)
	(set-face-attribute 'default nil
						:inherit nil
						:stipple nil
						:inverse-video nil
						:box nil
						:strike-through nil
						:overline nil
						:underline nil
						:slant 'normal
						:weight 'normal
						:height 100
						:width 'normal
						:foundry "apple"
						:family "Monaco")
)

;;
;; Load vendor files
;;
(add-to-list 'load-path "~/.emacs.d/vendor/")

;;
;; Mac-specific options
;;
(setq mac-command-modifier 'meta) 	; Use command as meta
(setq mac-option-mofifier 'none)	; Don't use option key
; PATH is not inherited when launching from Finder so we
; have to manually add to Emacs' exec-path
(when (string-equal system-type "darwin")
  (setq exec-path (append exec-path '("/usr/local/bin"))))


;;
;; GUI options
;;
(tool-bar-mode -1)
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-scroll-amount '(2 ((shift) . 2) ((control) . nil)))
; Display full path to file in title bar
(setq frame-title-format
      '(buffer-file-name "%f" (dired-directory dired-directory "%b")))

;;
;; Speedbar
;;
(require 'speedbar)
(define-key speedbar-file-key-map (kbd "<C-up>") 'speedbar-restricted-prev)
(define-key speedbar-file-key-map (kbd "<C-down>") 'speedbar-restricted-next)

; Turn on case-insensitive search in speedbar
(add-hook 'speedbar-mode-hook (lambda () (setq case-fold-search t)))

; Speedbar parameters. I like the speedbar to be a little wider
(setq speedbar-frame-parameters
	  (quote
	   (
		(minibuffer)
		(width . 30)
		(border-width . 0)
		(menu-bar-lines . 0)
		(tool-bar-lines . 0)
		(unsplittable . t)
		(left-fringe . 0))))

;;
;; copy or cut a whole line if there is no region, otherwise, behave as usual
;;
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

;;
;; Windmove
;;
(require 'windmove)
(windmove-default-keybindings 'meta)

;;
;; Linum mode
;;
(add-hook 'python-mode-hook 'linum-mode)
(add-hook 'lisp-mode-hook 'linum-mode)
(add-hook 'emacs-lisp-mode-hook 'linum-mode)
(setq linum-eager nil)

;;
;; 'Delete selection' mode
;;
(delete-selection-mode 1)

;;
;; ido-mode
;;
(require 'ido)
(ido-mode t)
(ido-everywhere t) ; NB: use C-j to accept without completion
(setq ido-enable-flex-matching t) ; fuzzy matching is a must have
(setq ido-create-new-buffer 'always)
(setq confirm-nonexistent-file-or-buffer nil)

;;
;; Hippie expand
;;
;; Don't be so eager to complete from filenames
;; Integrate with YASnippet
(setq hippie-expand-try-functions-list
	  '(yas/hippie-try-expand
		try-expand-dabbrev
		try-expand-dabbrev-all-buffers
		try-expand-dabbrev-from-kill
 		try-complete-file-name-partially
		try-complete-file-name
		try-expand-all-abbrevs
		try-expand-list
		try-expand-line
		try-complete-lisp-symbol-partially
		try-complete-lisp-symbol))


;;
;; Snippets
;;
(add-to-list 'load-path "~/.emacs.d/vendor/yasnippet-0.6.1c/")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/vendor/yasnippet-0.6.1c/snippets/")
; Use pretty prompt for selecting among different snippets
(setq yas/prompt-functions '(yas/x-prompt yas/dropdown-prompt))

;;
;; Save the desktop
;;
(require 'desktop)
(desktop-save-mode 1)
(setq desktop-restore-eager 20)
(setq desktop-dirname "~")
(setq desktop-path '("~"))

;;
;; Enable recent file list
;;
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;;
;; Fill column indicator
;;
(require 'fill-column-indicator)
(add-hook 'python-mode-hook 'fci-mode)
(add-hook 'emacs-lisp-mode-hook 'fci-mode)
(setq default-fill-column 90)

;;
;; Dired
;;
(require 'dired)
(setq dired-listing-switches "-alh")
(setq dired-isearch-filenames t)
(put 'dired-find-alternate-file 'disabled nil)
; Tell dired not to open directories and files in a new buffer
(define-key dired-mode-map (kbd "<return>") 'dired-find-alternate-file)

;;
;; Whitespace
;;
(require 'whitespace)
(setq default-tab-width 4)

;;
;; Misc
;;
; Make sure all backup files only live in one place
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

; Make apropos find more stuff
(setq apropos-do-all t)

; Start emacs server
(server-start)

; Show current column number in modeline
(column-number-mode)

; Don't prompt when killing a buffer that contains a running process
(remove-hook 'kill-buffer-query-functions 'process-kill-buffer-query-function)

; Select the help window after invoking help
(setq help-window-select t)

; Don't show the startup screen
(setq inhibit-startup-message t)

; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

; Show matching parens
(show-paren-mode t)

; Highlight current line everywhere
(global-hl-line-mode t)

;;
;; Functions
;;
(defun comment-or-uncomment-line (&optional lines)
  "Comment current line. Argument gives the number of lines
forward to comment"
  (interactive "P")
  (comment-or-uncomment-region
   (line-beginning-position)
   (line-end-position lines)))

(defun comment-or-uncomment-region-or-line (&optional lines)
  "If the line or region is not a comment, comments region
if mark is active, line otherwise. If the line or region
is a comment, uncomment."
  (interactive "P")
  (if mark-active
	  (if (< (mark) (point))
		  (comment-or-uncomment-region (mark) (point))
		(comment-or-uncomment-region (point) (mark))
		)
	(comment-or-uncomment-line lines)))

;;
;; Auto-indent after yanking
;;
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
		   (and (not current-prefix-arg)
				(member major-mode '(emacs-lisp-mode lisp-mode
													 clojure-mode    scheme-mode
													 haskell-mode    ruby-mode
													 rspec-mode      python-mode
													 c-mode          c++-mode
													 objc-mode       latex-mode
													 plain-tex-mode))
				(let ((mark-even-if-inactive transient-mark-mode))
				  (indent-region (region-beginning) (region-end) nil))))))

;;
;; Global keymap
;;
(global-set-key (kbd "<kp-delete>") 'delete-char)
(global-set-key (kbd "<C-kp-delete>") 'kill-word)
(global-set-key (kbd "<home>") 'beginning-of-line)
(global-set-key (kbd "<end>") 'end-of-line)
(global-set-key "\C-c\C-b" 'speedbar-get-focus)
(global-set-key "\C-v" 'yank)
(global-set-key "\M-v" 'yank-pop)
(global-set-key "\C-z" 'undo)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(global-set-key "\M-;" 'comment-or-uncomment-region-or-line)
(global-set-key "\C-h\C-v" 'apropos-variable)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-S-n") 'make-frame-command)
(global-set-key (kbd "<M-f4>") 'delete-frame)
; Buf move
(require 'buffer-move)
(global-set-key (kbd "<M-S-down>") 'buf-move-down)
(global-set-key (kbd "<M-S-up>") 'buf-move-up)
(global-set-key (kbd "<M-S-left>") 'buf-move-left)
(global-set-key (kbd "<M-S-right>") 'buf-move-right)


;;
;; Set up specific languages
;;
(load-file "~/.emacs.d/python.el")

;;
;; Flymake
;;
(add-hook 'find-file-hook 'flymake-find-file-hook)

;;
;; Autocomplete
;;
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor/ac-dict")
(ac-config-default)
(setq ac-menu-height 20)
(setq ac-quick-help-height 40)
(setq ac-auto-start nil)
(ac-set-trigger-key "C-SPC")

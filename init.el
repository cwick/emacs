;;;; Set up paths to libraries
;;;; 3rd party libraries go in ~/.emacs.d/vendor/
;;;; Personal customizations go in ~/.emacs.d/

;; Set library load paths
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/vendor/")

;; Add all subdirectories of 'vendor'
(progn (cd "~/.emacs.d/vendor/")
       (normal-top-level-add-subdirs-to-load-path))

;; Make sure data directory exists
(make-directory "~/.emacs.d/data/" t)

;; Install packages to 'vendor' directory
(setq package-user-dir "~/.emacs.d/vendor/elpa")

;; Add scripts to exec-path
(add-to-list 'exec-path "~/.emacs.d/scripts/")

;;;;
;;;; Load libraries that don't yet have personal customizations
;;;;
(load-library "flymake-cursor")
(require 'nav)
(require 'magit)

;;;;
;;;; Load personal customizations
;;;;


;; My color theme
(load-library "cwick-color-theme")

;; My fonts
(load-library "cwick-font")

;; Interactively do things
(load-library "cwick-ido")

;; Easy moving between windows
(load-library "cwick-windmove")

;; GUI
(load-library "cwick-gui")

;; Fill column indicator
(load-library "cwick-fci")

;; eshell
(load-library "cwick-eshell")

;; Quickly open recent files
(load-library "cwick-recentf")

;; Better text expansions
(load-library "cwick-hippie")

;; Dired (Directory edit)
(load-library "cwick-dired")

;; line numbers
(load-library "cwick-linum")

;; Manage whitespace
(load-library "cwick-whitespace")

;; Speedbar
(load-library "cwick-speedbar")

;; Buffer management
(load-library "cwick-buffer")

;; Search
(load-library "cwick-find")

;; Python stuff
(load-library "cwick-python")

;; Javascript
(load-library "cwick-javascript")

;; Lisp
(load-library "cwick-lisp")

;; OSX-specific stuff
(if (eq system-type 'darwin)
	(load-library "cwick-osx"))

;; Windows-specific stuff
(if (eq system-type 'windows-nt)
	(load-library "cwick-cygwin"))

;; Other stuff
(load-library "cwick-misc")

;; My global keymap
(load-library "cwick-global-keymap")

;; Restore the desktop
(load-library "cwick-desktop")


;; ;;
;; ;; Snippets
;; ;;
;; (add-to-list 'load-path "~/.emacs.d/vendor/yasnippet-0.6.1c/")
;; (require 'yasnippet)
;; (yas/initialize)
;; (yas/load-directory "~/.emacs.d/vendor/yasnippet-0.6.1c/snippets/")
;; ; Use pretty prompt for selecting among different snippets
;; (setq yas/prompt-functions '(yas/x-prompt yas/dropdown-prompt))

;; ;;
;; ;; Whitespace
;; ;;
;; (require 'whitespace)
;; (setq default-tab-width 4)

;; ;;
;; ;; Functions
;; ;;
;; (defun comment-or-uncomment-line (&optional lines)
;;   "Comment current line. Argument gives the number of lines
;; forward to comment"
;;   (interactive "P")
;;   (comment-or-uncomment-region
;;    (line-beginning-position)
;;    (line-end-position lines)))

;; (defun comment-or-uncomment-region-or-line (&optional lines)
;;   "If the line or region is not a comment, comments region
;; if mark is active, line otherwise. If the line or region
;; is a comment, uncomment."
;;   (interactive "P")
;;   (if mark-active
;; 	  (if (< (mark) (point))
;; 		  (comment-or-uncomment-region (mark) (point))
;; 		(comment-or-uncomment-region (point) (mark))
;; 		)
;; 	(comment-or-uncomment-line lines)))

;; ;;
;; ;; Auto-indent after yanking
;; ;;
;; (dolist (command '(yank yank-pop))
;;   (eval `(defadvice ,command (after indent-region activate)
;; 		   (and (not current-prefix-arg)
;; 				(member major-mode '(emacs-lisp-mode lisp-mode
;; 													 clojure-mode    scheme-mode
;; 													 haskell-mode    ruby-mode
;; 													 rspec-mode      python-mode
;; 													 c-mode          c++-mode
;; 													 objc-mode       latex-mode
;; 													 plain-tex-mode))
;; 				(let ((mark-even-if-inactive transient-mark-mode))
;; 				  (indent-region (region-beginning) (region-end) nil))))))

;; ;;
;; ;; Global keymap
;; ;;
;; (global-set-key (kbd "<kp-delete>") 'delete-char)
;; (global-set-key (kbd "<C-kp-delete>") 'kill-word)
;; (global-set-key (kbd "<home>") 'beginning-of-line)
;; (global-set-key (kbd "<end>") 'end-of-line)
;; (global-set-key "\C-c\C-b" 'speedbar-get-focus)
;; (global-set-key "\C-v" 'yank)
;; (global-set-key "\M-v" 'yank-pop)
;; (global-set-key "\C-z" 'undo)
;; (global-set-key "\C-x\ \C-r" 'recentf-open-files)
;; (global-set-key "\M-;" 'comment-or-uncomment-region-or-line)
;; (global-set-key "\C-h\C-v" 'apropos-variable)
;; (global-set-key (kbd "M-/") 'hippie-expand)
;; (global-set-key (kbd "C-S-n") 'make-frame-command)
;; (global-set-key (kbd "<M-f4>") 'delete-frame)
;; ; Buf move
;; (require 'buffer-move)
;; (global-set-key (kbd "<M-S-down>") 'buf-move-down)
;; (global-set-key (kbd "<M-S-up>") 'buf-move-up)
;; (global-set-key (kbd "<M-S-left>") 'buf-move-left)
;; (global-set-key (kbd "<M-S-right>") 'buf-move-right)


;; ;;
;; ;; Set up specific languages
;; ;;
;; (load-file "~/.emacs.d/python.el")

;; ;;
;; ;; Flymake
;; ;;
;; (add-hook 'find-file-hook 'flymake-find-file-hook)

;; ;;
;; ;; Autocomplete
;; ;;
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor/ac-dict")
;; (ac-config-default)
;; (setq ac-menu-height 20)
;; (setq ac-quick-help-height 40)
;; (setq ac-auto-start nil)
;; (ac-set-trigger-key "C-SPC")
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(menu-bar-mode t)
 '(show-paren-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#3f3f3f" :foreground "#dcdccc" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "Inconsolata"))))
 '(font-lock-constant-face ((t (:inherit font-lock-type-face)))))

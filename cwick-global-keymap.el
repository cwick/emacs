;;;; Global keymap

;;; Set up some Windows-like keybindings
(global-set-key (kbd "C-v") 'yank)		; Windows-style ctrl+v paste
(global-set-key (kbd "M-v") 'yank-pop)	; Cycle through kill ring
(global-set-key (kbd "C-z") 'undo)		; Windows-style ctrl+z undo

;; Make home and end behave like they do on Windows
(global-set-key (kbd "<home>") 'beginning-of-line)
(global-set-key (kbd "<end>") 'end-of-line)
(global-set-key (kbd "<C-home>") 'beginning-of-buffer)
(global-set-key (kbd "<C-end>") 'end-of-buffer)
;; Make sure delete and backspace keys work
;; TODO: this causes backspace to stop working in incremental search
;; (global-set-key (kbd "<kp-delete>") 'delete-char)
;; (global-set-key (kbd "<backspace>") 'backward-delete-char-untabify)

;; Skip around quickly using the arrow keys
(global-set-key (kbd "<C-left>") 'backward-word)
(global-set-key (kbd "<C-up>") 'backward-paragraph)
(global-set-key (kbd "<C-right>") 'forward-word)
(global-set-key (kbd "<C-down>") 'forward-paragraph)

;; Delete more stuff with Ctrl modifier
(global-set-key (kbd "<C-delete>") 'kill-word)
(global-set-key (kbd "<C-kp-delete>") 'kill-word)
(global-set-key (kbd "<C-backspace>") 'backward-kill-word)

;; Use the buffer menu (same as buffer list but displays in current buffer)
(global-set-key (kbd "C-x C-b") 'buffer-menu)

;; Replace default text expand with hippie expand
(global-set-key (kbd "M-/") 'hippie-expand)

;; Quickly open recent files
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; Bury buffer by default
(global-set-key (kbd "C-x k") 'bury-buffer)
(global-set-key (kbd "C-x K") 'kill-buffer) ;Be explicit if we really want to kill it

;; Quick open file in tags table
(global-set-key (kbd "M-t") 'ido-find-file-in-tag-files)

;; Cycle through active frames
(global-set-key (kbd "M-`") 'other-frame)

;; Quick search through some files
(global-set-key (kbd "C-S-f") 'rgrep)

;;;
;;; Function keys
;;;
(global-set-key (kbd "<f1>") 'speedbar-get-focus)


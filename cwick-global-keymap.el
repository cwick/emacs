;;;; Global keymap

;;; Set up some Windows-like keybindings
(global-set-key (kbd "C-v") 'yank)		; Windows-style ctrl+v paste
(global-set-key (kbd "M-v") 'yank-pop)	; Cycle through kill ring
(global-set-key (kbd "C-z") 'undo)		; Windows-style ctrl+z undo

;; Make home and end behave like they do on Windows
(global-set-key (kbd "<home>") 'back-to-indentation-or-beginning)
(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)
(global-set-key (kbd "<end>") 'end-of-line)
(global-set-key (kbd "<C-home>") 'beginning-of-buffer)
(global-set-key (kbd "<C-end>") 'end-of-buffer)
;; Make sure delete key works on osx
(global-set-key (kbd "<kp-delete>") 'delete-char)

;; Skip around quickly using the arrow keys
(global-set-key (kbd "<C-left>") 'backward-word)
(global-set-key (kbd "<C-up>") 'backward-paragraph)
(global-set-key (kbd "<C-right>") 'forward-word)
(global-set-key (kbd "<C-down>") 'forward-paragraph)

;; Delete more stuff with Ctrl modifier
(global-set-key (kbd "<C-delete>") 'smart-kill-word)
(global-set-key (kbd "<C-kp-delete>") 'smart-kill-word)

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

;; Close current frame
(global-set-key (kbd "<M-f4>") 'delete-frame)

;; Quick search through some files
(global-set-key (kbd "C-S-f") 'rgrep)

;; Automatically indent after inserting a newline
;; NB: use "RET" here so the return key continues to work properly in the minibuffer
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "M-RET") 'newline)

;; Quickly open a new line above or below the current one
(global-set-key (kbd "<S-return>") 'open-line-above)
(global-set-key (kbd "<C-return>") 'open-line-below)


;; Run magit
(global-set-key (kbd "C-c k") 'magit-status)

;; Save some buffers without asking
(global-set-key (kbd "C-x s") (lambda() (interactive) (save-some-buffers t)))

;;;
;;; Function keys
;;;
(global-set-key (kbd "<f1>") 'speedbar-get-focus)
(global-set-key (kbd "<f12>") 'toggle-window-dedicated)


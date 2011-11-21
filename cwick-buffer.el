;;;; Easy buffer management

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; Swap the positions of two buffers
(require 'buffer-move)
(global-set-key (kbd "<M-S-down>") 'buf-move-down)
(global-set-key (kbd "<M-S-up>") 'buf-move-up)
(global-set-key (kbd "<M-S-left>") 'buf-move-left)
(global-set-key (kbd "<M-S-right>") 'buf-move-right)


;; Toggle window dedication
(defun toggle-window-dedicated ()
  "Toggle whether the current active window is dedicated or not"
  (interactive)
  (message 
   (if (let (window (get-buffer-window (current-buffer)))
		 (set-window-dedicated-p window 
								 (not (window-dedicated-p window))))
	   "Window '%s' is dedicated"
	 "Window '%s' is normal")
   (current-buffer)))

;; Sort by File column by default in buffer list
(setq Buffer-menu-sort-column 4)

;;;; Easy buffer management

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; Swap the positions of two buffers
(require 'buffer-move)
(global-set-key (kbd "<M-S-down>") 'buf-move-down)
(global-set-key (kbd "<M-S-up>") 'buf-move-up)
(global-set-key (kbd "<M-S-left>") 'buf-move-left)
(global-set-key (kbd "<M-S-right>") 'buf-move-right)

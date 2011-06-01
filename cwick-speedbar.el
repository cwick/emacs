;;;; Speedbar customizations

(require 'speedbar)

;; Skip over nodes with C-up / C-down
(define-key speedbar-file-key-map (kbd "<C-up>") 'speedbar-restricted-prev)
(define-key speedbar-file-key-map (kbd "<C-down>") 'speedbar-restricted-next)

;; Show all files
(setq speedbar-show-unknown-files t)

;; Hooks
(add-hook 'speedbar-mode-hook 
		  (lambda ()
			(setq case-fold-search t)	; Enable case-insensitive search
			(speedbar-disable-update)))

;; Speedbar parameters. I like the speedbar to be a little wider
(setq speedbar-frame-parameters
	  `(
		(minibuffer)
		(width . 30)
		(border-width . 0)
		(menu-bar-lines . 0)
		(tool-bar-lines . 0)
		(unsplittable . t)
		(left-fringe . 0)))

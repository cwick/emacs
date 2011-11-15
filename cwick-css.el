;; CSS mode customizations

(add-hook
 'css-mode-hook
 (lambda ()
   (setq css-indent-offset 2)
   (local-set-key (kbd "RET") 'newline-and-indent)
   (setup-electric-pairs css-mode-map)))

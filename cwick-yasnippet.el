;;; Yasnippet customization
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/vendor/yasnippet/snippets/")
; Use pretty prompt for selecting among different snippets
(setq yas/prompt-functions '(yas/x-prompt yas/dropdown-prompt))

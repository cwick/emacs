;;;; Tramp configuration
(require 'tramp)
(setq tramp-default-method "scp")
(setq tramp-default-user "deploy")
(setq tramp-persistency-file-name "~/.emacs.d/data/tramp")

;;;; Fill column indicator
(require 'fill-column-indicator)
(add-hook 'python-mode-hook 'fci-mode)
(add-hook 'emacs-lisp-mode-hook 'fci-mode)
(setq-default fill-column 90)

(setq fci-style 'rule)
(setq fci-always-use-textual-rule t)


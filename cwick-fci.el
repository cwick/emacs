;;;; Fill column indicator
(require 'fill-column-indicator)
(defun fci-mode-enable ()
  (fci-mode t))

(add-hook 'emacs-lisp-mode-hook 'fci-mode-enable)
(setq-default fill-column 90)

(setq fci-style 'rule)
(setq fci-always-use-textual-rule nil)
(setq fci-rule-width 2)
(setq fci-rule-color "#cccccc")


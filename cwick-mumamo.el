;; Multi major mode
(require 'nxhtml-mode)
(load "~/.emacs.d/vendor/nxhtml/util/mumamo-fun.el")

;; Enable mumamo automatically
(add-to-list 'auto-mode-alist '("\\.htm\\'" . html-mumamo-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . html-mumamo-mode))
(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . eruby-html-mumamo))
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-html-mumamo))

;; Need to set this otherwise Mumamo does not pick the correct indent function
(setq mumamo-indent-major-to-use '((html-mode html-mode)))
;; Only color first submode
(setq mumamo-chunk-coloring 7)

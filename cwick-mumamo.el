;; Multi major mode
(load "~/.emacs.d/vendor/nxhtml/util/mumamo-fun.el")

; Enable mumamo whenever we load an html file
(add-to-list 'auto-mode-alist '("\\.html\\'" . html-mumamo-mode))
; Need to set this otherwise Mumamo does not pick the correct indent function
(setq mumamo-indent-major-to-use '((html-mode html-mode)))
; Only color first submode
(setq mumamo-chunk-coloring 1)

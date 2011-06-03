;;;; Set GUI options
;; toolbar? we don't need no stinkin' toolbar
(tool-bar-mode -1)
(menu-bar-mode -1)                      ; Ditto for menus

;; Enable copy/paste between emacs and other applications
(setq x-select-enable-clipboard t)

;; Display full path to file in title bar
(setq frame-title-format
      '(buffer-file-name "%f" (dired-directory dired-directory "%b")))

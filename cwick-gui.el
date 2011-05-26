;;;; Set GUI options
;; toolbar? we don't need no stinkin' toolbar
(tool-bar-mode -1)
;; Display full path to file in title bar
(setq frame-title-format
      '(buffer-file-name "%f" (dired-directory dired-directory "%b")))

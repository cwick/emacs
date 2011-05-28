;;;; Dired mode

(require 'dired)
(setq dired-listing-switches "-alh")	; give us more information about files
(setq dired-isearch-filenames t)		; isearch in filenames only

;; Tell dired not to open directories and files in a new buffer
(put 'dired-find-alternate-file 'disabled nil)
(define-key dired-mode-map (kbd "<return>") 'dired-find-alternate-file)

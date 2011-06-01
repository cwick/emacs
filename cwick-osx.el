;;;; Mac-specific options
(setq mac-command-modifier 'meta) 	; Use command as meta
(setq mac-option-mofifier 'none)	; Don't use option key

; PATH is not inherited when launching from Finder so we
; have to manually add to Emacs' exec-path
(add-to-list 'exec-path "/usr/local/bin")
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin:~/.emacs.d/scripts/"))

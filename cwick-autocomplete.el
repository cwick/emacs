;;
;; Autocomplete
;;
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor/auto-complete/dict/")
(ac-config-default)
(setq ac-menu-height 20)
(setq ac-quick-help-height 40)
(setq ac-auto-start nil)
;(ac-set-trigger-key "C-SPC")
(ac-set-trigger-key "TAB")


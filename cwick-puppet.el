;;
;; Setup puppet-mode for autoloading
;;
(autoload 'puppet-mode "puppet-mode" "Major mode for editing puppet manifests")

(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))


(add-hook 'puppet-mode-hook
          (lambda ()
            (progn
              ;; Turn on electric pairs
              (setup-electric-pairs puppet-mode-map))))

;;;; Lisp modes

(add-hook 'emacs-lisp-mode-hook
          (lambda()
            (define-key emacs-lisp-mode-map (kbd "(") 'electric-pair)
            (define-key emacs-lisp-mode-map (kbd ")") 'smart-close-paren)
            (define-key emacs-lisp-mode-map (kbd "\"") 'smart-quotes)
            (define-key emacs-lisp-mode-map (kbd "DEL") 'smart-backspace)))
                                   


(add-hook 'lisp-mode-hook
          (lambda()
            (define-key lisp-mode-map (kbd "(") 'electric-pair)
            (define-key lisp-mode-map (kbd ")") 'smart-close-paren)
            (define-key lisp-mode-map (kbd "\"") 'smart-quotes)
            (define-key lisp-mode-map (kbd "DEL") 'smart-backspace)))


(add-hook 'lisp-interaction-mode-hook
          (lambda()
            (define-key lisp-mode-shared-map (kbd "(") 'electric-pair)
            (define-key lisp-mode-shared-map (kbd ")") 'smart-close-paren)
            (define-key lisp-mode-shared-map (kbd "\"") 'smart-quotes)
            (define-key lisp-mode-shared-map (kbd "DEL") 'smart-backspace)))

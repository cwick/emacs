;;;; Javascript mode

(add-hook 'js-mode-hook (lambda ()
  ;; Key bindings
  (setup-electric-pairs js-mode-map)

  ;; Settings
  (setq whitespace-style '(face tab-mark indentation))
  (whitespace-mode)
))

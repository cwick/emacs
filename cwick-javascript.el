;;;; Javascript mode


(add-hook 'js-mode-hook (lambda ()
  ;; Settings
  (setq whitespace-style '(face tab-mark indentation))
  (setq js-indent-level 2)
  (whitespace-mode)
  (autopair-mode t)
  (fci-mode t)
))

; Javascript and CoffeeScript
(require 'js2-mode)
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

;; Coffee-mode key bindings
(add-hook 'coffee-mode-hook '(lambda ()
                               (define-key coffee-mode-map (kbd "M-r") 'coffee-compile-buffer)
                               (autopair-mode t)
                               (fci-mode t)))
                               ;(define-key coffee-mode-map (kbd "RET") 'newline-and-indent)


;;; Hook up coffeescript to flymake
(setq flymake-coffeescript-err-line-patterns
  '(("\\(Error: In \\([^,]+\\), .+ on line \\([0-9]+\\).*\\)" 2 3 nil 1)))

(defconst flymake-allowed-coffeescript-file-name-masks
  '(("\\.coffee$" flymake-coffeescript-init)
    ("Cakefile$"  flymake-coffeescript-init)))

(defun flymake-coffeescript-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-in-system-tempdir))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "coffee" (list local-file))))

(defun flymake-coffeescript-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks
        (append flymake-allowed-file-name-masks
                flymake-allowed-coffeescript-file-name-masks))
  (setq flymake-err-line-patterns flymake-coffeescript-err-line-patterns)
  (flymake-mode t))

(add-hook 'coffee-mode-hook 'flymake-coffeescript-load)

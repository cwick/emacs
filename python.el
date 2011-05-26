;;
;; Integrate pyflakes with flymake
;;
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
	(let* ((temp-file (flymake-init-create-temp-buffer-copy
			   'flymake-create-temp-inplace))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name))))
	  (list "pyflakes" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
		   '("\\.py\\'" flymake-pyflakes-init)))


;;
;; Python-specific whitespace settings
;;
(add-hook 'python-mode-hook (lambda () 
  (setq whitespace-style '(face tab-mark indentation))
))

;;
;; Python-specific keybindings
;;
(add-hook 'python-mode-hook (lambda ()
  (define-key python-mode-map (kbd "<return>") 'newline-and-indent)
  (define-key python-mode-map (kbd "(") 'electric-pair)
  (define-key python-mode-map (kbd "\"") 'electric-pair)
  (define-key python-mode-map (kbd "\'") 'electric-pair)
  (define-key python-mode-map (kbd "[") 'electric-pair)
  (define-key python-mode-map (kbd "{") 'electric-pair)
))
(defun electric-pair ()
  "Insert character pair without surrounding spaces"
  (interactive)
  (let (parens-require-spaces)
	(insert-pair)))


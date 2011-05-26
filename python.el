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
;  (define-key python-mode-map (kbd "<C-down>") 'python-next-statement)
 ; (define-key python-mode-map (kbd "<C-up>") 'python-previous-statement)
  (define-key python-mode-map (kbd "<return>") 'newline-and-indent)
))


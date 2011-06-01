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
  (whitespace-mode)
))

;;
;; Python-specific keybindings
;;
(add-hook 'python-mode-hook (lambda ()
  (define-key python-mode-map (kbd "<return>") 'newline-and-indent)
  (define-key python-mode-map (kbd "(") 'python-electric-pair)
  (define-key python-mode-map (kbd ")") 'python-smart-close-paren)
  (define-key python-mode-map (kbd "\"") 'python-smart-quotes)
  (define-key python-mode-map (kbd "\'") 'python-smart-quotes)
  (define-key python-mode-map (kbd "[") 'python-electric-pair)
  (define-key python-mode-map (kbd "{") 'python-electric-pair)
))

;;
;; Smart electric characters
;;
(defun python-electric-pair ()
  "Insert character pair without surrounding spaces"
  (interactive)
  (let (parens-require-spaces)
	(insert-pair)))

(defun python-smart-close-paren ()
  "Don't insert a closing parenthesis if there is already one at point."
  (interactive)
  (if (and
	   (not (eobp))
	   (or (equal (string (char-after)) ")")))
	  (forward-char)
	(insert-char ?\) 1)))
		
(defun python-smart-quotes ()
  "Use electric quotes, but don't insert anything if there's already a quote under the point"
  (interactive)
  (if (and
	   (not (eobp))
	   (or
		(equal (string (char-after)) "\"")
		(equal (string (char-after)) "\'")))
	  (forward-char)
	(python-electric-pair)))
	


;;
;; Fix indentation
;;
(defadvice python-calculate-indentation (around outdent-closing-brackets)
  "Handle lines beginning with a closing bracket and indent them so that
  they line up with the line containing the corresponding opening bracket."
  (save-excursion
	(beginning-of-line)
	(let ((syntax (syntax-ppss)))
	  (if (and (not (eq 'string (syntax-ppss-context syntax)))
			   (python-continuation-line-p)
			   (cadr syntax)
			   (skip-syntax-forward "-")
			   (looking-at "\\s)"))
		  (progn
			(forward-char 1)
			(ignore-errors (backward-sexp))
			(setq ad-return-value (current-indentation)))
		ad-do-it))))

(ad-activate 'python-calculate-indentation)
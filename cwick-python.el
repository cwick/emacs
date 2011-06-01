;;
;; Integrate pyflakes with flymake
;;
(when (load "flymake" t)
  (require 'tramp)

  (defun flymake-create-temp-in-system-tempdir (filename prefix)
	(make-temp-file (or prefix "flymake")))

  (defun flymake-pyflakes-init ()
	; Make sure it's not a remote buffer or flymake would not work
	(when (not (subsetp (list (current-buffer)) (tramp-list-remote-buffers)))
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
						 'flymake-create-temp-in-system-tempdir))
             (local-file (file-relative-name
						  temp-file
						  (file-name-directory buffer-file-name))))
		(list "pychecker" (list temp-file)))))

  (add-to-list 'flymake-allowed-file-name-masks
			   '("\\.py\\'" flymake-pyflakes-init)))

;;
;; Python-specific settings
;;
(add-hook 'python-mode-hook (lambda ()
  ;; Key bindings
  (define-key python-mode-map (kbd "<return>") 'newline-and-indent)
  (define-key python-mode-map (kbd "(") 'python-electric-pair)
  (define-key python-mode-map (kbd ")") 'python-smart-close-paren)
  (define-key python-mode-map (kbd "\"") 'python-smart-quotes)
  (define-key python-mode-map (kbd "\'") 'python-smart-quotes)
  (define-key python-mode-map (kbd "[") 'python-electric-pair)
  (define-key python-mode-map (kbd "{") 'python-electric-pair)

  ;; Settings
  (setq whitespace-style '(face tab-mark indentation))
  (whitespace-mode)
  (setq flymake-log-level 4)
  (flymake-mode)
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

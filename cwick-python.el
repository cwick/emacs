;;
;; Integrate pyflakes with flymake
;;
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-in-system-tempdir))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pychecker"  (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))

;;
;; Python-specific settings
;;
(add-hook 'python-mode-hook (lambda ()
  ;; Key bindings
  (setup-electric-pairs python-mode-map)

  ;; Settings
  (setq whitespace-style '(face tab-mark indentation))
  (whitespace-mode)
  (flymake-mode)
  ;; Python mode sets this to 8, so we have to set it back again
  (setq tab-width 4)
))

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

;; HTML mode customizations

(add-hook
 'html-mode-hook
 (lambda ()
   ;; Default indentation to 2, but let SGML mode guess, too.
   (set (make-local-variable 'sgml-basic-offset) 2)
   (sgml-guess-indent)
   (setq indent-line-function 'sgml-indent-line)
   (local-set-key (kbd "RET") 'newline-and-indent)
   (setup-electric-pairs html-mode-map)))

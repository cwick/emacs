;;;; Cygwin integration
;; from http://stackoverflow.com/questions/235254/how-can-i-run-cygwin-bash-shell-from-within-emacs
(when (eq system-type 'windows-nt)
  (setq binary-process-input t) 
  (setq w32-quote-process-args ?\")
  (setq shell-file-name "bash")
  (setenv "SHELL" shell-file-name)
  (setq explicit-shell-file-name shell-file-name)
  (setq explicit-bash-args '("-login" "-i")))
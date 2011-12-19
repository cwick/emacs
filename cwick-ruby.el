(require 'rvm)
(rvm-use-default) ;; use rvm's default ruby for the current Emacs session

(add-hook 'ruby-mode-hook
          (lambda ()
            (progn
              ;; Make newline also indent
              (local-set-key "\r" 'newline-and-indent)
              ;; Turn on electric mode
              (setup-electric-pairs ruby-mode-map)
              ;; Turn on syntax checking
              (flymake-mode)
              ;; Add Speedbar support
              (speedbar-add-supported-extension ".rb"))))

;; Fix indentation
(defadvice ruby-indent-line (after line-up-args activate)
  (let (indent prev-indent arg-indent)
    (save-excursion
      (back-to-indentation)
      (when (zerop (car (syntax-ppss)))
        (setq indent (current-column))
        (skip-chars-backward " \t\n")
        (when (eq ?, (char-before))
          (ruby-backward-sexp)
          (back-to-indentation)
          (setq prev-indent (current-column))
          (skip-syntax-forward "w_.")
          (skip-chars-forward " ")
          (setq arg-indent (current-column)))))
    (when prev-indent
      (let ((offset (- (current-column) indent)))
        (cond ((< indent prev-indent)
               (indent-line-to prev-indent))
              ((= indent prev-indent)
               (indent-line-to arg-indent)))
        (when (> offset 0) (forward-char offset))))))


;; Inferior Ruby shell
(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
(autoload 'inf-ruby-keys "inf-ruby" "" t)
(eval-after-load 'ruby-mode
  '(add-hook 'ruby-mode-hook 'inf-ruby-keys))



;;
;; Syntax checking
;;
(when (load "flymake" t)
  (defun flymake-ruby-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-in-system-tempdir))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "ruby" (list "-c" local-file))))
  (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
  (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

  (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns))

      

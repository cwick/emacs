;;;; Save the desktop

(require 'desktop)
(setq desktop-restore-eager 10)

;; Put desktop files in data directory
(setq desktop-dirname "~/.emacs.d/data/desktop/")
(setq desktop-path '("~/.emacs.d/data/desktop/"))
(setq desktop-base-file-name "desktop")
(setq desktop-base-lock-name "desktop.lock")
(setq desktop-save t)                   ; Always save desktop without prompting
;; Make sure desktop data directory exists
(make-directory "~/.emacs.d/data/desktop/" t)

;;; Remember the window size on exit
(add-hook 'kill-emacs-hook
		  (lambda ()
			(progn
			  (with-temp-buffer
				(insert
				 ";; -*- mode: emacs-lisp; coding: emacs-mule; -*-\n"
				 ";; Created " (current-time-string) "\n"
				 ";; Emacs version " emacs-version "\n")
				(print
				 `(setq initial-frame-alist
						'((width . ,(frame-width))
						  (height . ,(frame-height))
						  ,(assq 'top (frame-parameters))
						  ,(assq 'left (frame-parameters))))
				 (current-buffer))
				(write-file "~/.emacs.d/data/desktop/winsize")))))

;; Restore the window size on startup
(load "~/.emacs.d/data/desktop/winsize" t nil t)

;; Save minibuffer history in data directory
(setq savehist-file "~/.emacs.d/data/history")
(desktop-save-mode 1)
(savehist-mode 1)

;;; Run syntax check on everything after buffers have been restored
(defun flymake-start-syntax-check-all ()
  "Runs flymake on all open buffers that have flymake mode enabled"
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (if flymake-mode
          (flymake-start-syntax-check)))))

;; We have to run this after a delay or else syntax check errors won't show up
;; I tried the following:
;; (add-hook 'desktop-delay-hook 'flymake-start-syntax-check-all)
;; But it had no effect

(run-at-time
 "5 seconds"
 nil
 'flymake-start-syntax-check-all)
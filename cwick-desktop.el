;;;; Save the desktop

(require 'desktop)
(desktop-save-mode 1)
(setq desktop-restore-eager 10)

;; Put desktop files in data directory
(setq desktop-dirname "~/.emacs.d/data/desktop/")
(setq desktop-path '("~/.emacs.d/data/desktop/"))
(setq desktop-base-file-name "desktop")
(setq desktop-base-lock-name "desktop.lock")
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

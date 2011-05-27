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

;;; Remember the window size
(defun restore-saved-window-size()
  (unless (load "~/.emacs.d/data/desktop/winsize" t nil t)
    (setq saved-window-size '(80 30)))
  (nconc default-frame-alist `((width . ,(car saved-window-size))
                   (height . ,(cadr saved-window-size)))))

(defun save-window-size-if-changed (&optional unused)
  (let ((original-window-size  `(,(frame-width) ,(frame-height))))
    (unless (equal original-window-size saved-window-size)
      (with-temp-buffer
        (setq saved-window-size original-window-size) 
        (insert (concat "(setq saved-window-size '"
                        (prin1-to-string saved-window-size) ")"))
        (write-file "~/.emacs.d/data/desktop/winsize")))))

(add-hook 'window-size-change-functions 'save-window-size-if-changed)
(restore-saved-window-size)
;;;; Tools for NuMUD development


(defvar numud-home "~/dev/NuMUD/"
  "Root NuMUD directory")

;; Builder
;(defvar numud-builder-process nil)
(defvar numud-builder-process-buffer-name "*numud-build*"
  "Buffer name for building NuMUD")

;; Server
(defvar numud-server-process nil)
(defvar numud-server-process-buffer-name "*numud-server*")

(defun numud-rebuild-and-restart ()
  (interactive)
  (save-some-buffers t)
  (if (numud-rebuild)
      (numud-restart)))

(defun numud-restart ()
  "Restart the NuMUD server"
  (interactive)
  (if numud-server-process
      (delete-process numud-server-process))
  (let ((buf (get-buffer-create numud-server-process-buffer-name))
        (inhibit-read-only t))
    (with-current-buffer buf
      (cd numud-home)
      (erase-buffer)
      (set-window-dedicated-p
       (get-buffer-window numud-server-process-buffer-name) 1)
      (setq numud-server-process
            (start-process-shell-command
             "numud-server"
             numud-server-process-buffer-name
             "cake runserver")))))


(defun numud-rebuild ()
  "Rebuild NuMUD files"
  (interactive)
  (let ((buf (get-buffer-create numud-builder-process-buffer-name))
        (inhibit-read-only t))
    (with-current-buffer buf
      (cd numud-home)
      (erase-buffer)
      (set-window-dedicated-p
       (get-buffer-window numud-builder-process-buffer-name) 1)
        (if (= (call-process-shell-command
                "cake build"
                nil
                numud-builder-process-buffer-name
                t)
               0)
            (progn (insert "Build succeeded") t)
          nil))))
  


(define-key coffee-mode-map (kbd "<f5>") 'numud-rebuild-and-restart)



;;; Set up windows for NuMUD development
(defun numud-layout ()
  (interactive)
  (delete-other-windows)

  (let* ((right-window (split-window-horizontally))
         (build-window (split-window right-window))
         (server-window  (split-window-vertically))
         (server-buffer (get-buffer-create numud-builder-process-buffer-name))
         (build-buffer  (get-buffer-create numud-server-process-buffer-name)))
    (set-window-buffer build-window build-buffer)
    (set-window-buffer server-window server-buffer)

    (dolist (win (list server-window build-window))
      (with-current-buffer (window-buffer win)
        (setq window-size-fixed nil)
        (set-window-text-height win 10)
        (set-window-dedicated-p win t)
        (setq buffer-read-only t)))))

(numud-layout)

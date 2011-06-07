;;;; Tools for NuMUD development


(defvar numud-home "~/NuMUD/"
  "Root NuMUD directory")

;; Builder
;(defvar numud-builder-process nil)
(defvar numud-builder-process-buffer-name "*numud-builder*"
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
  (if numud-server-process
      (delete-process numud-server-process))
  (let ((buf (get-buffer-create numud-server-process-buffer-name)))
    (with-current-buffer buf
      (cd numud-home)
      (erase-buffer)
      (set-window-dedicated-p
       (get-buffer-window numud-server-process-buffer-name) 1)
      (setq numud-server-process
            (start-process-shell-command
             "numud-server"
             numud-server-process-buffer-name
             "node lib/server.js")))))


(defun numud-rebuild ()
  "Rebuild NuMUD files"
  (let ((buf (get-buffer-create numud-builder-process-buffer-name)))
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
;;;; Search for things in buffers and files
(require 'grep)
(defun find-in-buffers (regexp)
  (interactive 
   (list (read-regexp "Find in open buffers" (car regexp-history))))
  (occur-1 regexp nil (buffer-list)))

(define-key grep-mode-map (kbd "<S-tab>") 'compilation-previous-error)


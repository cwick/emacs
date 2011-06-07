;;;; Search for things in buffers and files
(require 'grep)
(defun find-in-buffers (regexp)
  (interactive 
   (list (read-regexp "Find in open buffers" (car regexp-history))))
  (occur-1 regexp nil (buffer-list)))

;; Use shift-tab to go to previous match
(define-key grep-mode-map (kbd "<S-tab>") 'compilation-previous-error)

;; Pass the -I flag to grep, which tells it to ignore binary files.
;; This lets us significantly reduce the length of the ignore files list.
(if (not (eq system-type 'gnu/linux))
    (setq grep-find-template "find . <X> <F> -type f -exec grep <C> -InH -e <R> {} /dev/null \\;")
  (setq grep-find-template "find . <X> <F> -type f -print0 | \"xargs\" -0 -e grep -I <C> -nH -e <R>"))

;; Reduce the length of the ignored files list to reduce clutter in the *grep* buffer
(setq grep-find-ignored-files '(".#*" "*~"))

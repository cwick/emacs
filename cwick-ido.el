;;;; Load ido (interactive do)

(require 'ido)
(ido-mode t)
(ido-everywhere t) ; NB: use C-j to accept without completion
(setq ido-enable-flex-matching t) ; fuzzy matching is a must have
(setq ido-create-new-buffer 'always)
(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-auto-merge-work-directories-length -1) ; don't auto-find

;; Explicit key map for auto-merge
(define-key ido-file-dir-completion-map (kbd "C-c C-s") 
  (lambda() 
    (interactive)
    (ido-initiate-auto-merge (current-buffer))))

;; Quickly open a file listed in the current tags table
(defun ido-find-file-in-tag-files ()
  "Use ido to quickly open a file listed in the current tags table."
  (interactive)
  (save-excursion
	(let ((enable-recursive-minibuffers t)) (visit-tags-table-buffer))
	(find-file (expand-file-name
				(ido-completing-read "Project file: "
									 (tags-table-files) nil t)))))

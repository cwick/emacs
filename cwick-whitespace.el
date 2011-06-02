;;;; Functions for dealing with whitespace

(defun whack-whitespace ()
      "Delete all white space from point to the next word."
      (interactive)
      (let ((regexp "[ \t\n]+"))
        (re-search-forward regexp nil t)
        (replace-match "" nil nil)))

(defun smart-kill-word (arg)
  "If point is at end-of-line, kill all whitespace between point and the next word,
otherwise behave like kill-word"
  (interactive "P")
  (if (eolp)
	  (whack-whitespace)
	(kill-word arg)))

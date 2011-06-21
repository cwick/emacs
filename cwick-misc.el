;;;; Miscellaneous tweaks and options that don't fit anywhere else
(delete-selection-mode 1)		; Typed text replaces current selection

;; Make sure all backup files live in one place
(setq backup-directory-alist '((".*" . "~/.emacs.d/data/backups/")))
;; Put autosave files in temp directory
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
;; Save autosave list in data directory
(setq auto-save-list-file-prefix "~/.emacs.d/data/auto-save-list/saves-")

;; Make apropos find more stuff
(setq apropos-do-all t)

;; Start emacs server
(setq server-auth-dir "~/.emacs.d/data/server/")
(unless (server-running-p) (server-start))

;; Show current column number in modeline
(column-number-mode)

;; Don't prompt when killing a buffer that contains a running process
(remove-hook 'kill-buffer-query-functions 'process-kill-buffer-query-function)

;; Select the help window after invoking help
(setq help-window-select t)

;; Don't show the startup screen
(setq inhibit-startup-message t)

;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Show matching parens
(show-paren-mode t)
(setq show-paren-style 'mixed)

;; Highlight current line everywhere
(global-hl-line-mode t)

;; Display tabs as 4 characters wide
(setq default-tab-width 4)

;; Always use UNIX style line endings
(setq default-buffer-file-coding-system 'unix)

;; Don't use tabs for indentation
(setq-default indent-tabs-mode nil)

;; Ensure newlines at end of files
(setq require-final-newline t)

;; copy or cut a whole line if there is no region, otherwise, behave as usual
(put 'kill-ring-save 'interactive-form
	 '(interactive
	   (if (use-region-p)
		   (list (region-beginning) (region-end))
		 (list (line-beginning-position) (line-beginning-position 2)))))
(put 'kill-region 'interactive-form
	 '(interactive
	   (if (use-region-p)
		   (list (region-beginning) (region-end))
		 (list (line-beginning-position) (line-beginning-position 2)))))


;;
;; Useful things for editing any kind of file
;;
(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline-and-indent)
  (previous-line)
  (indent-for-tab-command))

(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline-and-indent))


;;; Smart electric characters
(defun electric-pair ()
  "Insert character pair without surrounding spaces"
  (interactive)
  (let ((last-char (event-basic-type last-command-event))
        (cur-pair (assq (char-before) insert-pair-alist)))
    (if (or
         ;; Are we at the end of the line?
         (eolp)
         ;; Are we inside another electric pair?
         (and
          cur-pair
          (equal (char-after) (nth 0 (cdr cur-pair)))))
        (let (parens-require-spaces)
          (insert-pair))
      (self-insert-command 1))))

(defun smart-close-bracket ()
  "Don't insert a closing bracket if there is already one at point."
  (interactive)
  (smart-close-char ?\] ))

(defun smart-close-paren ()
  "Don't insert a closing parenthesis if there is already one at point."
  (interactive)
  (smart-close-char ?\) ))

(defun smart-close-brace ()
  "Don't insert a closing brace if there is already one at point."
  (interactive)
  (smart-close-char ?\} ))

(defun smart-close-char (c)
  (if (and
	   (not (eobp))
	   (or (equal (char-after) c)))
	  (forward-char)
	(insert-char c 1)))
		
(defun smart-quotes ()
  "Use electric quotes, but don't insert anything if there's already a quote under the point"
  (interactive)
  (let ((last-char (event-basic-type last-command-event)))
    (if (and
         (not (eobp))
         (equal last-char (char-after)))
        (forward-char)
      (electric-pair))))

;; TODO: my LISP sucks. How to simplify this?
(defun looking-at-electric-pair-p ()
  (or
   (and
    (equal (char-after) ?\')
    (equal (char-before) ?\'))
   (and
    (equal (char-after) ?\")
    (equal (char-before) ?\"))
   (and
    (equal (char-after) ?\])
    (equal (char-before) ?\[))
   (and
    (equal (char-after) ?\})
    (equal (char-before) ?\{))
   (and
    (equal (char-after) ?\))
    (equal (char-before) ?\())))

(defun smart-backward-kill-word (arg)
  (interactive "p")
  (if (looking-at-electric-pair-p)
      (progn
        (smart-backspace)
        (backward-kill-word arg))
    (backward-kill-word arg)))

(defun smart-backspace ()
  "Delete electric pairs when backspacing, if possible"
  (interactive)
  (if (looking-at-electric-pair-p)
      (progn
        (delete-char 1)
        (delete-char -1))
    (backward-delete-whitespace-to-column)))

(defun setup-electric-pairs (map)
  (define-key map (kbd "(") 'electric-pair)
  (define-key map (kbd ")") 'smart-close-paren)
  (define-key map (kbd "}") 'smart-close-brace)
  (define-key map (kbd "\"") 'smart-quotes)
  (define-key map (kbd "\'") 'smart-quotes)
  (define-key map (kbd "[") 'electric-pair)
  (define-key map (kbd "]") 'smart-close-bracket)
  (define-key map (kbd "{") 'electric-pair)
  (define-key map (kbd "DEL") 'smart-backspace))

;; Make sure everything works with delete selection mode
(put 'smart-backspace 'delete-selection 'supersede)
(put 'smart-quotes 'delete-selection t)
(put 'smart-close-paren 'delete-selection t)
(put 'smart-close-bracket 'delete-selection t)
(put 'smart-close-brace 'delete-selection t)
(put 'electric-pair 'delete-selection t)


;; Do what I mean version of beginning-of-line
(defun back-to-indentation-or-beginning ()
   (interactive "^")
   (if (= (point) (save-excursion (back-to-indentation) (point)))
       (beginning-of-line)
     (back-to-indentation)))


;; Handy function for having flymake create its temp files in the system temp directory
(defun flymake-create-temp-in-system-tempdir (filename prefix)
  (make-temp-file (or prefix "flymake")))


(defun backward-delete-whitespace-to-column ()
  "delete back to the previous column of whitespace, or as much whitespace as possible,
or just one char if that's not possible"
  (interactive)
  (if indent-tabs-mode
      (call-interactively 'backward-delete-char-untabify)
    (let ((movement (% (current-column) tab-width))
          (p (point)))
      (when (= movement 0) (setq movement tab-width))
      (save-match-data
        (if (and
             (not (bolp))
             (string-match "\\w*\\(\\s-+\\)$" (buffer-substring-no-properties (- p movement) p)))
            (backward-delete-char-untabify (- (match-end 1) (match-beginning 1)))
          (call-interactively 'backward-delete-char-untabify))))))

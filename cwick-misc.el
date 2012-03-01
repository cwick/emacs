;;;; Miscellaneous tweaks and options that don't fit anywhere else
;;(delete-selection-mode 1)		; Typed text replaces current selection
(setq cua-enable-cua-keys nil) ;; only for rectangles
(cua-mode t)

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

;; Auto revert changed buffers
(global-auto-revert-mode 1)

;; Save some buffers when compiling
(setq compilation-ask-about-save nil)

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
  (previous-line)
  (end-of-line)
  (newline-and-indent))

(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

;; "Do what I mean" version of beginning-of-line
(defun back-to-indentation-or-beginning ()
   (interactive "^")
   (if (= (point) (save-excursion (back-to-indentation) (point)))
       (beginning-of-line)
     (back-to-indentation)))
;; Allow shift + home to work
(put 'back-to-indentation-or-beginning 'CUA 'move)


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


(defun fixup-text-mode ()
  (setq indent-line-function 'insert-tab)
  (local-set-key (kbd "RET") 'newline))

(add-hook 'text-mode-hook 'fixup-text-mode)


;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))


;; http://chopmo.blogspot.com/2008/09/quickly-jumping-to-symbols.html
(defun ido-goto-symbol ()
  "Will update the imenu index and then use ido to select a
   symbol to navigate to"
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))

                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))

                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))

                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (goto-char position))))

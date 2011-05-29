;;;; Line numbers

;; Adapted from http://www.emacswiki.org/emacs/linum-off.el

(defcustom linum-disabled-modes-list 
  '(eshell-mode wl-summary-mode compilation-mode org-mode text-mode dired-mode speedbar-mode)
  "* List of modes disabled when global linum mode is on"
  :type '(repeat (sexp :tag "Major mode"))
  :tag " Major modes where linum is disabled: "
  :group 'linum
  )

(defun linum-on ()
  "* When linum is running globally, disable line number in modes defined in
`linum-disabled-modes-list'. Changed by linum-off. Also turns off numbering in starred
modes (except for *scratch*)"
  
  (unless (or (minibufferp) (member major-mode linum-disabled-modes-list)
              (and (not (eq (buffer-name) "*scratch*")) 
				   (string-match "*" (buffer-name))))
    (linum-mode 1)))


(global-linum-mode 1)			; Show line numbers everywhere
(setq linum-eager nil)			; Better linum performance

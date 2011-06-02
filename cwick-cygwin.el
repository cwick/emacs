;;;; Cygwin integration

;; from http://stackoverflow.com/questions/235254/how-can-i-run-cygwin-bash-shell-from-within-emacs
(when (eq system-type 'windows-nt)
  ;(setq binary-process-input t) 
  ;(setq w32-quote-process-args ?\")
  ;(setq shell-file-name "bash")
  ;(setenv "SHELL" shell-file-name)
  ;(setenv "PS1" "Hello > ")
  ;(setq explicit-shell-file-name shell-file-name)
  ;(setq explicit-bash-args '("-i"))
)

;; Remove windows directories from path to avoid conflicts with GNU tools (e.g. find)
;; (setq exec-path 
;; 	  (remove-if 
;; 	   (lambda (dir) 
;; 		 (string-prefix-p "c:/windows" dir t))
;; 	   exec-path))

;; Add cygwin to path. Should come first in the list to make sure
;; the cygwin tools are found before the Windows ones
(add-to-list 'exec-path "c:/dev/cygwin/bin")

;; Set PATH the same as exec-path
(setenv "PATH" (mapconcat 'identity exec-path ";"))

;; Prevent issues with the Windows null device (NUL)
;; when using cygwin find with rgrep.
(defadvice grep-compute-defaults (around grep-compute-defaults-advice-null-device)
  "Use cygwin's /dev/null as the null-device."
  (let ((null-device "/dev/null"))
	ad-do-it))
(ad-activate 'grep-compute-defaults)


;;; Initialization code taken from http://www.cygwin.com/faq/faq.using.html#faq.using.ntemacs

;;   LOGNAME and USER are expected in many Emacs packages
;;   Check these environment variables.

(if (and (null (getenv "USER"))
		 ;; Windows includes variable USERNAME, which is copied to
		 ;; LOGNAME and USER respectively.
		 (getenv "USERNAME"))
	(setenv "USER" (getenv "USERNAME")))

(if (and (getenv "LOGNAME")
		 ;;  Bash shell defines only LOGNAME
		 (null (getenv "USER")))
	(setenv "USER" (getenv "LOGNAME")))

(if (and (getenv "USER")
		 (null (getenv "LOGNAME")))
	(setenv "LOGNAME" (getenv "USER")))

;; Use bash instead of the Windows command interpreter
(setq shell-file-name "bash")
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)
(setq explicit-bash-args '("--noediting" "-i"))
;(setq explicit-sh-args '("--login" "-i"))

;; Remove C-m (^M) characters that appear in output

(add-hook 'comint-output-filter-functions
		  'comint-strip-ctrl-m)

;; Other environment
(setenv "LANG" "C.UTF-8")
(setenv "CYGWIN" "nodosfilewarning tty")

;; Teach emacs to understand cygwin paths. This should come last
(require 'cygwin-mount)
(cygwin-mount-activate)

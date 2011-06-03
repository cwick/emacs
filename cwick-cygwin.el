;;;; Cygwin integration

;; Explicity set the path
(setq exec-path
      '("c:/Python27"
        "c:/Python27/Scripts"
        "c:/Python27/Lib/site-packages/django/bin"
        "c:/dev/cygwin/bin"
        "c:/dev/node/bin"
        "~/.emacs.d/scripts"))

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

;; Remove C-m (^M) characters that appear in output

(add-hook 'comint-output-filter-functions
		  'comint-strip-ctrl-m)

;; Other environment
(setenv "LANG" "C.UTF-8")
(setenv "CYGWIN" "nodosfilewarning tty")

;; Teach emacs to understand cygwin paths. This should come last
(require 'cygwin-mount)
(cygwin-mount-activate)

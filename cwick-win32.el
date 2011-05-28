;;;; Customizations for running on Windows systems

;; Remove windows directories from path to avoid conflicts with GNU tools (e.g. find)
;; (setq exec-path 
;; 	  (remove-if 
;; 	   (lambda (dir) 
;; 		 (string-prefix-p "c:/windows" dir t))
;; 	   exec-path))


;; (setq exec-path '("c:\\dev\\cygwin\\bin"))
;; (setenv "PATH" "c:\\dev\\cygwin\\bin")

;; Prevent issues with the Windows null device (NUL)
;; when using cygwin find with rgrep.
(defadvice grep-compute-defaults (around grep-compute-defaults-advice-null-device)
  "Use cygwin's /dev/null as the null-device."
  (let ((null-device "/dev/null"))
	ad-do-it))
(ad-activate 'grep-compute-defaults)
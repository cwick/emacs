(require 'windmove)
(windmove-default-keybindings 'meta)

;; Overriden to not throw an error if no window to move to
(defun windmove-do-window-select (dir &optional arg window)
  "Move to the window at direction DIR.
DIR, ARG, and WINDOW are handled as by `windmove-other-window-loc'."
  (let ((other-window (windmove-find-other-window dir arg window)))
    (if (not (null other-window))
        (select-window other-window))))

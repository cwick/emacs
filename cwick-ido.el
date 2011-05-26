;;;; Load ido (interactive do)

(require 'ido)
(ido-mode t)
(ido-everywhere t) ; NB: use C-j to accept without completion
(setq ido-enable-flex-matching t) ; fuzzy matching is a must have
(setq ido-create-new-buffer 'always)
(setq confirm-nonexistent-file-or-buffer nil)

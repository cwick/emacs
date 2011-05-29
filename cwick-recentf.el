;;;; Enable recent file list

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 50)
(setq recentf-max-saved-items 100)
(setq recentf-save-file "~/.emacs.d/data/recentf")

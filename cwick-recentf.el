;;;; Enable recent file list

(require 'recentf)
(setq recentf-max-menu-items 50)
(setq recentf-max-saved-items nil)
(setq recentf-save-file "~/.emacs.d/data/recentf")
(recentf-mode 1)
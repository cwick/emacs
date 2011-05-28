;;;; Enable recent file list

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-save-file "~/.emacs.d/data/recentf")

;;;; Set up my color theme

;; Zenburn.
(require 'color-theme-zenburn)
(color-theme-zenburn)

(require 'linum)
;; Make line numbers match the region style
(set-face-attribute 'linum nil
            :foreground "#cccccc"
		    :inherit '(region shadow default))

;; Make (mis)matching parens more prominent
(set-face-attribute 'show-paren-match nil
		    :background "#7cb8bb"
		    :foreground zenburn-fg
		    :weight 'bold)

(set-face-attribute 'show-paren-mismatch nil
		    :background "#e37170"
		    :foreground zenburn-fg
		    :weight 'bold)

(set-face-attribute 'region nil
		    :background "#000000")

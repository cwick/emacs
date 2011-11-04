(add-hook 'ruby-mode-hook
          (lambda ()
            (progn
              ; Make newline also indent
              (local-set-key "\r" 'newline-and-indent)
              ; Turn on electric mode
              (setup-electric-pairs ruby-mode-map))))




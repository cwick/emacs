;; Use Consolas on Windows
(if (eq system-type 'windows-nt)
    (set-face-attribute 'default nil
			:slant 'normal 
			:weight 'normal 
			:height 98 
			:width 'normal 
			:foundry "outline" 
			:family "Consolas")
  )
;; Use Monaco on OSX
(if (eq system-type 'darwin)
    (set-face-attribute 'default nil
			:inherit nil
			:stipple nil
			:inverse-video nil
			:box nil
			:strike-through nil
			:overline nil
			:underline nil
			:slant 'normal
			:weight 'normal
			:height 100
			:width 'normal
			:foundry "apple"
			:family "Monaco")
  )

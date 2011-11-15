;; HTML mode customizations

(add-hook
 'html-mode-hook
 (lambda ()
   ;; Default indentation to 2, but let SGML mode guess, too.
   (set (make-local-variable 'sgml-basic-offset) 2)
   ;; Can't use sgml-guess-indent here because it breaks mumamo
   ;;(sgml-guess-indent)
   (setq indent-line-function 'sgml-indent-line)
   (local-set-key (kbd "RET") 'newline-and-indent)
   (setup-electric-pairs html-mode-map)
   ;; Always insert the closing tag
   (setq sgml-xml-mode t)
   ;; Don't display fill column indicator
   (fci-mode -1)
   

(setq html-tag-alist
  (let* ((1-7 '(("1") ("2") ("3") ("4") ("5") ("6") ("7")))
	 (1-9 `(,@1-7 ("8") ("9")))
	 (align '(("align" ("left") ("center") ("right"))))
	 (valign '(("top") ("middle") ("bottom") ("baseline")))
	 (rel '(("next") ("previous") ("parent") ("subdocument") ("made")))
	 (href '("href" ("ftp:") ("file:") ("finger:") ("gopher:") ("http:")
		 ("mailto:") ("news:") ("rlogin:") ("telnet:") ("tn3270:")
		 ("wais:") ("/cgi-bin/")))
	 (name '("name"))
	 (link `(,href
		 ("rel" ,@rel)
		 ("rev" ,@rel)
		 ("title")))
	 (list '((nil \n ("List item: " "<li>" str
                          (if sgml-xml-mode "</li>") \n))))
	 (cell `(t
		 ,@align
		 ("valign" ,@valign)
		 ("colspan" ,@1-9)
		 ("rowspan" ,@1-9)
		 ("nowrap" t))))
    ;; put ,-expressions first, else byte-compile chokes (as of V19.29)
    ;; and like this it's more efficient anyway
    `(("a" ,name ,@link)
      ("base" t ,@href)
      ("dir" ,@list)
      ("font" nil "size" ("-1") ("+1") ("-2") ("+2") ,@1-7)
      ("form" (\n _ \n "<input type=\"submit\" value=\"\""
	       (if sgml-xml-mode " />" ">"))
       ("action" ,@(cdr href)) ("method" ("get") ("post")))
      ("h1" ,@align)
      ("h2" ,@align)
      ("h3" ,@align)
      ("h4" ,@align)
      ("h5" ,@align)
      ("h6" ,@align)
      ("hr" t ("size" ,@1-9) ("width") ("noshade" t) ,@align)
      ("img" t ("align" ,@valign ("texttop") ("absmiddle") ("absbottom"))
       ("src") ("alt") ("width" "1") ("height" "1")
       ("border" "1") ("vspace" "1") ("hspace" "1") ("ismap" t))
      ("input" t ("size" ,@1-9) ("maxlength" ,@1-9) ("checked" t) ,name
       ("type" ("text") ("password") ("checkbox") ("radio")
	("submit") ("reset"))
       ("value"))
      ("link" t ,@link)
      ("menu" ,@list)
      ("ol" ,@list ("type" ("A") ("a") ("I") ("i") ("1")))
      ("p" t ,@align)
      ("select" (nil \n
		     ("Text: "
		      "<option>" str (if sgml-xml-mode "</option>") \n))
       ,name ("size" ,@1-9) ("multiple" t))
      ("table" (nil \n
		    ((completing-read "Cell kind: " '(("td") ("th"))
				      nil t "t")
		     "<tr><" str ?> _
		     (if sgml-xml-mode (concat "<" str "></tr>")) \n))
       ("border" t ,@1-9) ("width" "10") ("cellpadding"))
      ("td" ,@cell)
      ("textarea" ,name ("rows" ,@1-9) ("cols" ,@1-9))
      ("th" ,@cell)
      ("ul" ,@list ("type" ("disc") ("circle") ("square")))

      ("![" ("ignore" t) ("include" t))
      ("!attlist")
      ("!doctype")
      ("!element")
      ("!entity")

      ("abbrev")
      ("acronym")
      ("address")
      ("array" (nil \n
		    ("Item: " "<item>" str (if sgml-xml-mode "</item>") \n))
       "align")
      ("au")
      ("b")
      ("big")
      ("blink")
      ("blockquote" \n)
      ("body" \n ("background" ".gif") ("bgcolor" "#") ("text" "#")
       ("link" "#") ("alink" "#") ("vlink" "#"))
      ("box" (nil _ "<over>" _ (if sgml-xml-mode "</over>")))
      ("br" t ("clear" ("left") ("right")))
      ("caption" ("valign" ("top") ("bottom")))
      ("center" \n)
      ("cite")
      ("code" \n)
      ("dd" ,(not sgml-xml-mode))
      ("del")
      ("dfn")
      ("div")
      ("dl" (nil \n
		 ( "Term: "
		   "<dt>" str (if sgml-xml-mode "</dt>")
                   "<dd>" _ (if sgml-xml-mode "</dd>") \n)))
      ("dt" (t _ (if sgml-xml-mode "</dt>")
             "<dd>" (if sgml-xml-mode "</dd>") \n))
      ("em")
      ("fn" "id" "fn")  ;; Footnotes were deprecated in HTML 3.2
      ("head")
      ("html" ("lang"))
      ("i")
      ("ins")
      ("isindex" t ("action") ("prompt"))
      ("kbd")
      ("lang")
      ("li" ,(not sgml-xml-mode))
      ("math" \n)
      ("nobr")
      ("option" t ("value") ("label") ("selected" t))
      ("over" t)
      ("person") ;; Tag for person's name tag deprecated in HTML 3.2
      ("pre")
      ("q")
      ("rev")
      ("s")
      ("samp")
      ("small")
      ("span" nil
       ("class"
        ("builtin")
        ("comment")
        ("constant")
        ("function-name")
        ("keyword")
        ("string")
        ("type")
        ("variable-name")
        ("warning")))
      ("strong")
      ("sub")
      ("sup")
      ("title")
      ("tr" t)
      ("tt")
      ("u")
      ("var")
      ("wbr" t)
      ("header" ("id"))
      ("footer" ("id"))
      ("meta"   ("http-equiv") ("content"))
      ("script" ("src") ("type"))
      )))

   ; Replace default wih our own
   (setq sgml-tag-alist html-tag-alist)
   ))

(asdf:defsystem :shortage
  :serial t
  :description "simple url shortener application"
  :depends-on (:hunchentoot
	       :cl-mustache
	       :cl-fad
	       :alexandria
	       :postmodern)
  :components ((:file "package")
	       (:module :src
			:serial t      
			:components
			((:module :util
				  :serial t
				  :components ((:file "model-utils")
					       (:file "heroku-utils")
					       (:file "general-utils")
					       (:file "string-utils")
					       (:file "hunchentoot-utils")))
			 (:file "model")
			 (:file "controller")))))

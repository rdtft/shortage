(in-package :cl-user)

(print ">>> Building system....")

(load (merge-pathnames "shortage.asd" *build-dir*))

(ql:quickload :shortage)

;;; Redefine / extend heroku-toplevel here if necessary.

(print ">>> Done building system")

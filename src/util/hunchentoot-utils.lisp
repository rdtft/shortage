(in-package :shortage)

(defvar *ht-server*)

(defun start-server ()
    (setf *ht-server*
	  (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 5000))))

(defun stop-server ()
  (progn
    (hunchentoot:stop *ht-server*)
    (setf *ht-server* nil)))

(defun return-404 ()
    (setf (hunchentoot:return-code*) hunchentoot:+http-not-found+))

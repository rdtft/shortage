(in-package :shortage)

(defvar *hex-alphabet* "abcdef01234567890")

(defun random-string (&optional (length 4) (alphabet *hex-alphabet*))
  (loop with id = (make-string length)
     with alphabet-length = (length alphabet)
     for i below length
     do (setf (aref id i)
	      (aref alphabet (random alphabet-length)))
     finally (return id)))

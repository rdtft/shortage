(in-package :shortage)

(defclass url ()
  ((id :col-type serial :accessor url-id)
   (path :col-type string :initarg :path :accessor url-path)
   (alias :col-type string :initarg :alias :accessor url-alias))
  (:metaclass dao-class)
  (:keys id))

(deftable url
  (!dao-def)
  (!unique :alias))

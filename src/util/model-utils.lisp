(in-package :shortage)

(defun create-url-table ()
  (with-connection (db-params)
     (create-table 'url)))

(defun drop-url-table ()
  (with-connection (db-params)
     (execute (:drop-table 'url))))

(defun url-get-all ()
  (with-connection (db-params)
    (query-dao 'url (:order-by (:select '* :from 'url) (:desc 'id)))))

(defmacro url-get-by-alias (alias)
  (let ((a (gensym "alias")))
     `(let ((,a ,alias))
	(with-connection (db-params)
	   (car (select-dao 'url (:= 'alias ,a)))))))

(defmacro url-create (path alias)
  `(with-connection (db-params)
     (make-dao 'url :path ,path :alias ,alias)))

(defun create-uniq-alias (path)
  (handler-case
      (url-create path (random-string))
    (cl-postgres-error:unique-violation ()
      (create-uniq-alias path))))

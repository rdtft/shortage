(in-package :shortage)

(defmacro create-url-table ()
  (with-connection db-params
     (create-table 'url)))

(defmacro drop-url-table ()
  (with-connection db-params
     (execute (:drop-table 'url))))

(defun url-get-all ()
  (with-connection db-params
    (query-dao 'url (:order-by (:select '* :from 'url) (:desc 'id)))))

(defun url-get-all-public ()
  (with-connection db-params
    (query-dao 'url (:order-by (:select '* :from 'url :where (:= 'private "f") ) (:desc 'id)))))

(defun url-get-by-alias (alias)
  (with-connection db-params
    (car (select-dao 'url (:= 'alias alias)))))

(defun url-create (path alias &optional (private nil))
  (with-connection db-params
    (make-dao 'url :path path :alias alias :private private)))

(defun create-uniq-alias (path &optional (private nil))
  (handler-case
      (url-create path (random-string) private)
    (cl-postgres-error:unique-violation ()
      (create-uniq-alias path))))

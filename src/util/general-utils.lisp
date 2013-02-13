(in-package :shortage)

(defun url-p (s)
  (and (cl-ppcre:scan "^https?://" s) t))

(defun template-name (name)
  (concatenate 'string (string-downcase (symbol-name name)) ".mustache"))

(defun render (file &optional params)
  (let* ((layout (read-file-into-string "src/views/layout.mustache"))
	 (template (read-file-into-string
		    (merge-pathnames
		     (template-name file)
		     (merge-pathnames "src/views/"))))
	 (template-body (mustache-render-to-string template params)))
    (mustache-render-to-string layout `((:body . ,template-body)))))

(defun object-to-alist (o)
  ;; cl-mustache working only with simple string
  `((:path . ,(copy-seq (slot-value o 'path)))
    (:alias . ,(copy-seq (slot-value o 'alias)))))

(defun objects-to-alist (olist)
  (mapcar #'object-to-alist olist))

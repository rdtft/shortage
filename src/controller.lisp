(in-package :shortage)

(setq hunchentoot:*dispatch-table*
      (list (create-regex-dispatcher "^/$" 'index)
            (create-regex-dispatcher "^/new$" 'new)
            (create-regex-dispatcher "^/create$" 'create)
            (create-regex-dispatcher "^/[a-f0-9]{4}$" 'redirect-or-not-found)))

(defun index ()
  (render :index `((:urls ,@(objects-to-alist (url-get-all-public))))))

(defun new ()
  (render :new))

(defun redirect-or-not-found ()
  (let* ((alias (subseq (request-uri*) 1 5))
	 (obj (url-get-by-alias alias)))
    (if obj
        (redirect (slot-value obj 'path))
        (return-404))))

(defun create ()
  (let ((url (post-parameter "url"))
        (private (and (post-parameter "private") t)))
    (if (url-p url)
        (render :show (append (object-to-alist (create-uniq-alias url private)) `((:host . ,(hunchentoot:host)))))
        (render :new '((:errors . ((:error . "Please enter a valid URL to shorten")))))))) 

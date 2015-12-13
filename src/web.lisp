(in-package :cl-user)
(defpackage where-are-we.web
  (:use :cl
        :caveman2
        :where-are-we.config
        :where-are-we.view
        :where-are-we.util
        :cl-annot)
  (:export :*web*))
(in-package :where-are-we.web)

;;
;; Application

(defclass <web> (<app>) ())
(defvar *web* (make-instance '<web>))
(clear-routing-rules *web*)

;;
;; Routing rules
(enable-annot-syntax)

@route GET "/" 
(defun index ()
  (with-layout (:title "Where are we")
    (render #P"index.tmpl" (load-all-user))))


@route GET "/check"
(defun check (&key (|name| "blank title"))
  (with-layout (:title |name|)
    (render #P"index.tmpl")))


;;
;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))

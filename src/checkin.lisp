(in-package :where-are-we.web)
(enable-annot-syntax)
  
@route GET "/checkin/:hash"
(defun checkin (&rest params &key hash)
  (let ((name (find-name-from-hash (config :users) hash)))
    (print (concatenate 'string "name:" name))
    (unless (not (null name))
      (throw-code 403))
    (with-layout (:title (concatenate 'string "Welcome " name))
                  (render #P"checkin.tmpl" `(:hash ,hash)))))
       
  

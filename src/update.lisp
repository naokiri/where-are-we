(in-package :where-are-we.web)
(enable-annot-syntax)
  
@route POST "/update"
(defun updateState (&key |movestate| |note| |hash|)
  (with-open-file (s (merge-pathnames (config :datadir) |hash|)
                     :direction :output
                     :if-exists :overwrite
                     :if-does-not-exist :create)
    (print (encode-data |movestate| |note|) s))
  "updated <br/> <a href=\"/\">Back to index</a>")
      

(in-package :cl-user)
(defpackage where-are-we.util
  (:use :cl
        :where-are-we.config
        :cl-annot))
(in-package :where-are-we.util)

(enable-annot-syntax)

(defun hashed-name (name)
  @type string name  
  (let ((ret (ironclad:byte-array-to-hex-string
              (ironclad:digest-sequence :MD5
                                        (ironclad:ascii-string-to-byte-array
                                         (concatenate 'string name (config :name-salt)))))))
    
    ret))
  

@export     
(defun find-name-from-hash (namelist hash)
  @type list  namelist
  @type string hash
  (cond
    ((null namelist) nil)
    ((equal (hashed-name (car namelist)) hash)
     (car namelist))
    (t 
      (find-name-from-hash (cdr namelist) hash))))


@export
(defun encode-data (state note)
  "return stored style data. Now it's just an assoc list"
  `((:movestate . ,(parse-integer state))
    (:note . ,note)
    (:datetime . ,(get-universal-time))))

(defun num-to-state (num)
  (case num
    (0 "Else")
    (10 "Stay Hotel")
    (11 "Hotel -> Work")
    (12 "Stay Work")
    (13 "Work -> Hotel")
    (otherwise "Else")))

(defvar *day-names*
    '("Monday" "Tuesday" "Wednesday"
      "Thursday" "Friday" "Saturday"
      "Sunday"))

(defun time-to-string (time)
  (multiple-value-bind
        (second minute hour date month year day-of-week dst-p tz)
      (decode-universal-time time (config :timezone))
    @ignore second
    @ignore dst-p
    @ignore day-of-week
    @ignore tz
    (format nil "~2,'0d:~2,'0d, ~d/~d/~2,'0d"
            hour
            minute
            year
            month
            date)))
    

@export
(defun load-all-user ()
  "return all data in template env data style. "
  `(:users 
    ,(loop for user in (config :users) collect
          (with-open-file (strm (merge-pathnames (config :datadir) (hashed-name user))
                                :direction :input
                                :if-does-not-exist nil)
            (when (not (null strm))
              (let ((data (read strm)))
                (append `(:name ,user)
                        `(:state ,(num-to-state (cdr (assoc :movestate data))))
                        `(:date ,(time-to-string (cdr (assoc :datetime data))))
                        `(:note ,(cdr (assoc :note data))))))))))
 
(defun list-checkin-url ()
  "Admin use helper function. Show each url for checkin"
  (print (concatenate 'string "On env:" (appenv)))
  (let ((baseurl "http://localhost:8080/checkin/"))
    (loop for user in (config :users) do
         (print (concatenate 'string user ":" baseurl (hashed-name user))))))
       

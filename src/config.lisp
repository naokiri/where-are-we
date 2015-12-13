(in-package :cl-user)
(defpackage where-are-we.config
  (:use :cl)
  (:import-from :envy
                :config-env-var
                :defconfig)
  (:export :config
           :*application-root*
           :*static-directory*
           :*template-directory*
           :appenv
           :developmentp
           :productionp))
(in-package :where-are-we.config)

(setf (config-env-var) "APP_ENV")

(defparameter *application-root*   (asdf:system-source-directory :where-are-we))
(defparameter *static-directory*   (merge-pathnames #P"static/" *application-root*))
(defparameter *template-directory* (merge-pathnames #P"templates/" *application-root*))

(defconfig :common
    `(:databases ((:maindb :sqlite3 :database-name ":memory:"))
;      :error-log #P"/var/log/where-are-we.log"
      :users ("usera" "userb" "userc")
      :timezone 5))

(defconfig |development|    
    '(:name-salt "devsalt"
        :datadir "dev-db/"))
  

(defconfig |production|
    '(:name-salt "prodsalt"
        :datadir "db/"))

(defconfig |test|
  '())

(defun config (&optional key)
  (envy:config #.(package-name *package*) key))

(defun appenv ()
  (asdf::getenv (config-env-var #.(package-name *package*))))

(defun developmentp ()
  (string= (appenv) "development"))

(defun productionp ()
  (string= (appenv) "production"))


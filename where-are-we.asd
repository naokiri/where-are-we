(in-package :cl-user)
(defpackage where-are-we-asd
  (:use :cl :asdf))
(in-package :where-are-we-asd)

(defsystem where-are-we
  :version "0.0.1"
  :author "Naoaki Iwakiri"
  :license "MIT"
  :depends-on (:clack
               :caveman2
               :envy
               :cl-ppcre
               :cl-annot
               
               ;; HTML Template
               :cl-emb

               ;; For default json rendorer
               :datafly
               )
               

  :components ((:module "src"
                :components
                ((:file "main" :depends-on ("config" "view"))
                 (:file "web" :depends-on ("view" "util"))
                 (:file "checkin" :depends-on ("view" "web"))
                 (:file "update" :depends-on ("web"))
                 (:file "view" :depends-on ("config"))
                 (:file "util" :depends-on ("config"))
                 (:file "config"))))
  :description ""
  :in-order-to ((test-op (load-op where-are-we-test))))

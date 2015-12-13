(in-package :cl-user)
(defpackage where-are-we-test-asd
  (:use :cl :asdf))
(in-package :where-are-we-test-asd)

(defsystem where-are-we-test
  :author "Naoaki Iwakiri"
  :license ""
  :depends-on (:where-are-we
               :cl-test-more)
  :components ((:module "t"
                :components
                ((:file "where-are-we"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))

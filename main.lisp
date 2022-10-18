(uiop:define-package :funcallable
  (:nicknames :funcalable/main)
  (:use :cl)
  (:import-from :closer-mop
                :funcallable-standard-class
                :set-funcallable-instance-function)
  (:export :def-funcallable-class
           :def-funcall))
(in-package :funcallable)

(defmacro def-funcallable-class (name direct-superclasses direct-slots &rest options)
  `(defclass ,name ,direct-superclasses
     ,direct-slots
     (:metaclass funcallable-standard-class)
     ,@options))

(defmacro def-funcall (class lambda-list &body body)
  (let ((self (intern (symbol-name 'self))))
    `(defmethod initialize-instance :after ((,self ,class) &key)
       (set-funcallable-instance-function
        ,self
        (lambda ,lambda-list ,@body)))))

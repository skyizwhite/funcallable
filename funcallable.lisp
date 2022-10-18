(ql:quickload :closer-mop)

(defpackage :funcallable
  (:use :cl)
  (:nicknames :fc)
  (:import-from :closer-mop :funcallable-standard-class)
  (:export :funcallable-standard-class
           :def-funcall))
(in-package :funcallable)

(defmacro def-funcall (cls vars &body body)
  (let ((self (intern (symbol-name 'self))))
    `(defmethod initialize-instance :after ((,self ,cls) &key)
       (closer-mop:set-funcallable-instance-function
        ,self
        (lambda ,vars ,@body)))))

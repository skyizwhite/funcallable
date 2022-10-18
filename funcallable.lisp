(ql:quickload :closer-mop)

(defpackage :funcallable
  (:use :cl)
  (:export :def-funcallable-class
           :def-funcall))
(in-package :funcallable)

(defmacro def-funcallable-class (&body body)
  `(defclass ,@body (:metaclass closer-mop:funcallable-standard-class)))

(defmacro def-funcall (cls vars &body body)
  (let ((self (intern (symbol-name 'self))))
    `(defmethod initialize-instance :after ((,self ,cls) &key)
       (closer-mop:set-funcallable-instance-function
        ,self
        (lambda ,vars ,@body)))))

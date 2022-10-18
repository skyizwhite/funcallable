(uiop:define-package :funcallable
  (:nicknames :funcalable/main)
  (:use :cl)
  (:import-from :closer-mop
                :funcallable-standard-class
                :set-funcallable-instance-function)
  (:export :def-funcallable-class
           :def-funcall))
(in-package :funcallable)

(defmacro def-funcallable-class (&body body)
  `(defclass ,@body (:metaclass funcallable-standard-class)))

(defmacro def-funcall (cls vars &body body)
  (let ((self (intern (symbol-name 'self))))
    `(defmethod initialize-instance :after ((,self ,cls) &key)
       (set-funcallable-instance-function
        ,self
        (lambda ,vars ,@body)))))

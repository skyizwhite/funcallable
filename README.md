# Funcallable

Common Lisp utility for defining funcallable objects, minimal wrapper of [closer-mop](https://github.com/pcostanza/closer-mop)

# Motivation

This utility is useful when you want to implement a method like Python's `object.__call__`.

# Usage

Install via rowsell
```bash
$ ros install skyizwhite/funcallable
```

```lisp
(def-funcallable-class person ()
  ((name :initarg :name
         :reader name)))

(def-funcall person ()
  (format t "Hello, I'm ~a." (name self))) ; self is bound to the funcalled object.

(defparameter *taro* (make-instance 'person :name "Taro"))
(funcall *taro*) ; => Hello, I'm Taro.
```

(ns fw.lib.macros)

(defmacro ?
  "Strict equality comparison"
  [x y]
  `(identical? ~x ~y))

(defmacro a?
  "Evalute if the given value is an array"
  [x expr]
  `(if (.is-array Array ~x) ~expr ~x))

(defmacro l?
  "Length of the given value"
  [x]
  `(.-length ~x))

(defmacro c->
  "Clone the given array"
  [arr]
  `(.slice ~arr))

(defmacro empty?
  "Check if the given value is empty"
  [x]
  `(? (l? ~x) 0))

(defmacro once
  "Creates a function that is restricted
  to execute function once time"
  [lambda]
  `(let [call false]
     (fn [& args]
       (cond (not call)
         (apply ~lambda args)))))

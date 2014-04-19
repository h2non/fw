(ns fw.lib.macros)

(defmacro ?
  [x y]
  `(identical? ~x ~y))

(defmacro a?
  [x expr]
  `(if (.is-array Array ~x) ~expr ~x))

(defmacro once
  [lambda]
  `(let [call false]
     (fn [& args]
       (cond (not call)
         (apply ~lambda args)))))

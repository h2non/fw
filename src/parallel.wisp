(ns fw.lib.parallel
  (:require [fw.lib.util :refer [last filter-empty each]]))

(defn ^:private iterator
  [lambda len]
  (let [results []
        error nil]
    (once
      (fn [err result]
        (.push results result)
        (cond err (set! error err))
        (cond (? (.-length results) len)
          (lambda error (filter-empty results)))))))

(defn ^void parallel
  "Run the tasks array of functions in parallel"
  [arr lambda]
  (a? arr
    (let [len (.-length arr)
          next (iterator lambda len)]
      (each arr (fn [cur]
        (cond cur (cur next)))))))

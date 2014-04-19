(ns fw.lib.parallel
  (:require [fw.lib.util :refer [fn? once filter-empty]]))

(defn ^:private iterator
  [lambda len]
  (let [results []
        error nil]
    (fn [err result]
      (.push results result)
      (cond err (set! error err))
      (cond (? (l? results) len)
        (lambda error (filter-empty results))))))

(defn ^void parallel
  "Run the tasks array of functions in parallel"
  [arr lambda]
  (a? arr
    (let [arr (c-> arr)
          len (l? arr)
          next (iterator lambda len)]
      (each arr (fn [cur]
        (cond (fn? cur)
          (cur (once next))))))))

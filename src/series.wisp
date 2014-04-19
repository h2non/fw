(ns fw.lib.series
  (:require [fw.lib.util :refer [last]]))

(defn ^:private iterator
  [arr]
  (fn next [err result]
    (cond err (set! arr (last arr)))
    (let [len (.-length arr)
          cur (.shift arr)]
      (if (? len 1)
        (cur err result)
        (cur next err result)))))

(defn ^void series
  "Run the tasks array of functions in serie"
  [arr lambda]
  (a? arr
    (do
      (.push arr (if lambda lambda (fn [])))
      ((iterator arr)))))

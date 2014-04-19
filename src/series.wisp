(ns fw.lib.series
  (:require [fw.lib.util :refer [last uniq? filter-empty]]))

(defn ^:private iterator
  [arr]
  (let [results []]
    (fn next [err result]
      (.push results result)
      (if (or err (uniq? arr))
        ((last arr) err (filter-empty results))
        (let [cur (.shift arr)]
          (cond cur
            (cur next result)))))))

(defn ^void series
  "Run the tasks array of functions in serie"
  [arr lambda]
  (a? arr
    (let [arr (c-> arr)]
      (.push arr (if lambda lambda (fn [])))
      ((iterator arr)))))

(ns fw.lib.series
  (:require [fw.lib.util :refer [fn? once last uniq? filter-empty]]))

(defn ^:private iterator
  [arr]
  (let [results []]
    (fn next [err result]
      (.push results result)
      (if (or err (uniq? arr))
        ((last arr) err (filter-empty results))
        (let [cur (.shift arr)]
          (cond (fn? cur)
            (cur (once next) result)))))))

(defn ^void series
  "Run the tasks array of functions in serie"
  [arr lambda]
  (a? arr
    (let [arr (c-> arr)]
      (.push arr (if lambda lambda (fn [])))
      ((iterator arr)))))

(defn ^void each-series
  "Applies the function iterator to each
  item in array in serie"
  [arr lambda cb]
  (a? arr (do
    (let [stack (.map arr
                  (fn [item]
                    (fn [done]
                      (lambda item done))))]
    (series stack cb)))))

(def ^void map-series each-series)

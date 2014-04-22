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
        (cond (fn? lambda)
          (lambda error (filter-empty results)))))))

(defn ^void parallel
  "Run the tasks array of functions in parallel"
  [arr lambda]
  (a? arr
    (let [arr (c-> arr)
          len (l? arr)
          next (iterator lambda len)]
      (if (? (l? arr) 0)
        (cond
          (fn? lambda) (lambda nil []))
        (each arr (fn [cur]
          (cond (fn? cur)
            (cur (once next)))))))))

(defn ^void each
  "Applies the function iterator to each
  item in array in parallel"
  [arr lambda cb]
  (a? arr (do
    (let [stack (.map arr
                  (fn [item]
                    (fn [done]
                      (lambda item done))))]
      (parallel stack cb)))))

(def ^void map each)
(def ^void each-parallel each)
(def ^void map-parallel each)

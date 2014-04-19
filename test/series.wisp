(ns fw.test.series
  (:require
    [chai :refer [expect]]
    [fw.lib.series :refer [series]]))

(defn ^:private delay
  [lambda]
  (set-timeout lambda (* (.random Math) 100)))

(suite :series
  (fn []
    (test :basic
      (fn [done]
        (series
          [ (fn [next] (delay (fn [] (next))))
            (fn [next] (delay (fn [] (next nil 1))))
            (fn [next _ result] (delay (fn [] (next nil (+ result 1)))))
            (fn [next _ result] (delay (fn [] (next nil (* result 2))))) ]
          (fn [err result]
            (.to.be.equal (expect err) nil)
            (.to.be.equal (expect result) 4) (done)))))
    (test :error
      (fn [done]
        (series
          [ (fn [next] (delay (fn [] (next nil 1))))
            (fn [next _ result] (delay (fn [] (next :error result))))
            (fn [next] (delay (fn [] (next 2)))) ]
          (fn [err result]
            (.to.be.equal (expect err) :error)
            (.to.be.equal (expect result) 1) (done)))))))

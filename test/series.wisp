(ns fw.test.series
  (:require
    [chai :refer [expect]]
    [fw.lib.series :refer [series each-series]]))

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
            (fn [next result] (delay (fn [] (next nil (+ result 1)))))
            (fn [next result] (delay (fn [] (next nil (* result 2))))) ]
          (fn [err result]
            (.to.be.equal (expect err) nil)
            (.to.be.deep.equal (expect result) [1 2 4]) (done)))))
    (test :multicall
      (fn [done]
        (series
          [ (fn [next] (delay (fn [] (next))))
            (fn [next] (delay (fn [] (next nil 1) (next :error))))
            (fn [next result] (delay (fn [] (next nil (* result 2))))) ]
          (fn [err result]
            (.to.be.equal (expect err) nil)
            (.to.be.deep.equal (expect result) [1 2]) (done)))))
    (test :error
      (fn [done]
        (series
          [ (fn [next] (delay (fn [] (next nil 1))))
            (fn [next result] (delay (fn [] (next :error result))))
            (fn [next] (delay (fn [] (next 2)))) ]
          (fn [err result]
            (.to.be.equal (expect err) :error)
            (.to.be.deep.equal (expect result) [1 1]) (done)))))))

(suite :eachSeries
  (fn []
    (test :basic
      (fn [done]
        (each-series
          [1 2 3]
          (fn [item next] (delay (fn [] (next nil (* item 2)))))
          (fn [err result]
            (.to.be.equal (expect err) nil)
            (.to.be.an (expect result) :array)
            (.to.have.length (expect result) 3)
            (.to.include (expect result) 4)
            (.to.include (expect result) 6) (done)))))
    (test :error
      (fn [done]
        (each-series
          [1 2 3]
          (fn [item next] (delay (fn [] (next :error (* item 2)))))
          (fn [err result]
            (.to.be.equal (expect err) :error)
            (.to.be.an (expect result) :array)
            (.to.have.length (expect result) 1)
            (.to.include (expect result) 2) (done)))))))

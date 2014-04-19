(ns fw.test.parallel
  (:require
    [chai :refer [expect]]
    [fw.lib.parallel :refer [parallel each]]))

(defn ^:private delay
  [lambda]
  (set-timeout lambda (* (.random Math) 100)))

(suite :parallel
  (fn []
    (test :basic
      (fn [done]
        (parallel
          [ (fn [next] (delay (fn [] (next))))
            (fn [next] (delay (fn [] (next))))
            (fn [next] (delay (fn [] (next))))
            (fn [next] (delay (fn [] (next)))) ]
          (fn [err result]
            (.to.be.equal (expect err) nil)
            (.to.be.an (expect result) :array)
            (.to.have.length (expect result) 0) (done)))))
    (test :result
      (fn [done]
        (parallel
          [ (fn [next] (delay (fn [] (next nil 1))))
            (fn [next] (delay (fn [] (next nil))))
            (fn [next] (delay (fn [] (next nil 2))))
            (fn [next] (delay (fn [] (next nil)))) ]
          (fn [err result]
            (.to.be.equal (expect err) nil)
            (.to.be.an (expect result) :array)
            (.to.have.length (expect result) 2)
            (.to.include (expect result) 1)
            (.to.include (expect result) 2) (done)))))
    (test :multicall
      (fn [done]
        (parallel
          [ (fn [next] (delay (fn [] (next nil 1))))
            (fn [next] (delay (fn [] (next nil) (next :error))))
            (fn [next] (delay (fn [] (next nil 2) (next :fail))))
            (fn [next] (delay (fn [] (next nil)))) ]
          (fn [err result]
            (.to.be.equal (expect err) nil)
            (.to.be.an (expect result) :array)
            (.to.have.length (expect result) 2)
            (.to.include (expect result) 1)
            (.to.include (expect result) 2) (done)))))
    (test :error
      (fn [done]
        (parallel
          [ (fn [next] (delay (fn [] (next nil))))
            (fn [next] (delay (fn [] (next :error 1))))
            (fn [next] (delay (fn [] (next nil))))
            (fn [next] (delay (fn [] (next :fail 2)))) ]
          (fn [err result]
            (.to.be.a (expect err) :string)
            (.to.be.an (expect result) :array)
            (.to.have.length (expect result) 2)
            (.to.include (expect result) 1)
            (.to.include (expect result) 2) (done)))))))

(suite :each
  (fn []
    (test :basic
      (fn [done]
        (each
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
        (each
          [1 2 3]
          (fn [item next] (delay (fn [] (next :error (* item 2)))))
          (fn [err result]
            (.to.be.equal (expect err) :error)
            (.to.be.an (expect result) :array)
            (.to.have.length (expect result) 3)
            (.to.include (expect result) 4)
            (.to.include (expect result) 6) (done)))))))

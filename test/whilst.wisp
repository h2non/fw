(ns fw.test.whilst
  (:require
    [chai :refer [expect]]
    [fw.lib.whilst :refer [whilst]]))

(defn ^:private delay
  [lambda]
  (set-timeout lambda (* (.random Math) 100)))

(suite :whilst
  (fn []
    (test :basic
      (fn [done]
        (let [count 0]
          (whilst
            (fn [next] (< count 5))
            (fn [next]
              (set! count (+ count 1))
              (delay next))
            (fn [err]
              (.to.be.equal (expect err) nil)
              (.to.be.equal (expect count) 5) (done))))))
    (test :error
      (fn [done]
        (let [count 0]
            (whilst
              (fn [next] (< count 5))
              (fn [next]
                (set! count (+ count 1))
                (if (identical? count 3)
                  (delay (next :error))
                  (delay next)))
              (fn [err]
                (.to.be.equal (expect err) :error)
                (.to.be.equal (expect count) 3) (done))))))))

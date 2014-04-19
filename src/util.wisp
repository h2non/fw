(ns fw.lib.util)

(defn ^boolean fn?
  [x] (? (typeof x) :function))

(defn ^mixed last
  "Last item of the list"
  [arr]
  (.shift (.slice arr -1)))

(defn ^boolean uniq?
  "Return true if the given array has only one item"
  [arr]
  (? (l? arr) 1))

(defn ^array filter-empty
  "Remove empty values from an array"
  [arr]
  (a? arr
    (.filter arr
      (fn [x]
        (not (or
          (? x nil)
          (? x null)))))))

(defn ^fn once
  "Creates a function that is restricted
  to execute function once time"
  [lambda]
  (let [call false]
    (fn [& args]
      (cond (not call)
        (do
          (set! call true)
          (apply lambda args))))))

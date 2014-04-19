(ns fw.lib.util)

(defn ^mixed last
  "Last item of the list"
  [arr]
  (.shift (.slice arr -1)))

(defn ^boolean uniq?
  "Return true if the given array has only one item"
  [arr]
  (? (l? arr) 1))

(defn ^void each
  "Iterate an array passing a callback for each item"
  [arr lambda]
  (a? arr
    (.for-each arr lambda)))

(defn ^array filter-empty
  "Remove empty values from an array"
  [arr]
  (a? arr
    (.filter arr
      (fn [x]
        (not (or
          (? x nil)
          (? x null)))))))

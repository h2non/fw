(ns fw.lib.util)

(defn ^mixed last
  "Last item of the list"
  [arr]
  (.slice arr -1))

(defn ^void each
  [arr lambda]
  (.for-each arr lambda))

(defn ^array filter-empty
  [arr]
  (.filter arr
    (fn [x]
      (not (or
        (? x nil)
        (? x null))))))

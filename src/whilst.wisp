(ns fw.lib.whilst)

(defn ^void whilst
  "Repeatedly call a function, while test returns true
  Calls callback when stopped or an error occurs"
  [test lambda cb]
  (if (test)
    (lambda
      (fn [err]
        (if err
          (cb err)
          (whilst test lambda cb)))) (cb)))

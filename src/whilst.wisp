(ns fw.lib.whilst
  (:require [fw.lib.util :refer [fn? once]]))

(defn ^void whilst
  "Repeatedly call a function, while test returns true
  Calls callback when stopped or an error occurs"
  [test lambda cb]
  (cond (and (fn? test) (fn? lambda) (fn? cb))
    (if (test)
    (lambda (once
      (fn [err]
        (if err
          (cb err)
          (whilst test lambda cb))))) (cb))))

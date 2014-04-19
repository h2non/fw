(ns fw.lib.fw
  (:require
    [fw.lib.series :refer [series each-series]]
    [fw.lib.parallel :refer [parallel each]]
    [fw.lib.whilst :refer [whilst]]))

(def ^:private fw exports)
(set! (.-VERSION fw) :0.1.0)
(set! (.-series fw) series)
(set! (.-each-series fw) each-series)
(set! (.-parallel fw) parallel)
(set! (.-each fw) each)
(set! (.-whilst fw) whilst)

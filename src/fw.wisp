(ns fw.lib.fw
  (:require
    [fw.lib.series :refer [series each-series map-series]]
    [fw.lib.parallel :refer [parallel each map each-parallel map-parallel]]
    [fw.lib.whilst :refer [whilst]]))

(def ^:private fw exports)
(set! (.-VERSION fw) :0.1.2)
(set! (.-series fw) series)
(set! (.-each-series fw) each-series)
(set! (.-map-series fw) map-series)
(set! (.-parallel fw) parallel)
(set! (.-each fw) each)
(set! (.-map fw) map)
(set! (.-map-parallel fw) map-parallel)
(set! (.-each-parallel fw) each-parallel)
(set! (.-whilst fw) whilst)

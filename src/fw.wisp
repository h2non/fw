(ns fw.lib.fw
  (:require
    [fw.lib.series :refer [series]]
    [fw.lib.parallel :refer [parallel]]
    [fw.lib.whilst :refer [whilst]]))

(def ^:private fw exports)
(set! (.-VERSION fw) :0.1.0)
(set! (.-series fw) series)
(set! (.-parallel fw) parallel)
(set! (.-whilst fw) whilst)

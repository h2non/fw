module.exports = fw =

  whilst: (x, y, z) ->
    if x! then
      y (e) -> if e then z e else fw.whilst x, y, z
    else
      z!

  series: (arr, cb) !->
    arr.push cb ?= ->
    do next = (err, result) !->
      arr := [arr[arr.length - 1]] if err
      if arr.length is 1
        arr.shift! err, result
      else
        arr.shift! next, err, result

  parallel: (arr, cb) !->
    arr.push cb ?= ->
    next = (err) !->
      arr.shift!
      if err or arr.length is 1
        arr[arr.length - 1] err
        arr := []
    for i of arr
    when i < arr.length - 1
    then next |> arr[i]

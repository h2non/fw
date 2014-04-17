module.exports = fw =

  series: (arr, cb) !->
    arr.push cb ?= ->
    do next = (err, result) !->
      arr := [arr[arr.length - 1]] if err
      arr.shift! next, err, result

  parallel: (arr, cb) !->
    arr.push cb ?= ->
    next = (err) !->
      arr.shift!
      if err or 1 is arr.length
        arr[arr.length - 1] err
        arr := []
    for i of arr
    when i < arr.length - 1
    then next |> arr[i]

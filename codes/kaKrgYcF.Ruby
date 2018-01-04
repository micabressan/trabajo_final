def slice_arr arr, index, count
    ret_arr = arr[index..(index+count)] || []
    ret_arr + Array.new(count-ret_arr.size, 1)
end

arr = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
index = 25
count = 4

print slice_arr arr, index, count
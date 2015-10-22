class QuickSort
  attr_accessor :comparisons, :array
  
  def initialize
    @comparisons = 0
    @array = array_set #读数组进去
    #test_read
  end
  
  def array_set
    array = []
    File.open("QuickSort.txt", "r") do |f|
      f.each_line do |num|
        array << num.to_i
        #break if array.length == 3
      end
    end
    return array
  end
  
  def quick_sort(array)
    if array.length <= 1
      #@comparisons += 1 if array.length == 1
      return array
    end
=begin
    puts ""
    
    print "array now is #{array}"
    
    puts ""
    
    p = get_pivot(array)
    
    puts "the pivot is #{p}"
=end
    p = get_pivot(array)
    partition_array = partition(array, p)
    index = partition_array.index(p)
    array_first = []
    array_first = partition_array[0..(index-1)] if (index - 1) >= 0
    @comparisons += array_first.length if array_first.length >= 1
    array_second = []
    array_second = partition_array[(index+1)..(partition_array.length-1)] if (index+1 <= partition_array.length - 1)
    @comparisons += array_second.length if array_second.length >= 1
=begin
    print "comparison now is #{@comparisons}" + "\n"
    print "\n"
    print array_first
    print "     "
    print array_second
    puts ""
=end
    #return("false") if @comparisons == 29
    return quick_sort(array_first) + [p] + quick_sort(array_second)
  end
  
  def partition(array, p)
    #@comparisons += 1 if array.length == 1
    return array if array.length <= 1
    #@comparisons += array.length - 2
    
    index = array.index(p)
    #@comparisons += 1 if index != 0
    array[0], array[index] = array[index], array[0] #if index != 0 #swap the 2 element
    i = 1
    #@comparisons += array.length - 2
    for index in (1..(array.length - 1))
      if array[index] < p
        array[i], array[index] = array[index], array[i]
        i += 1
      end 
    end
    array[0], array[i-1] = array[i-1], array[0]
    return array
  end
  
  def get_pivot(array)
    #return array.first for first case
    #return array.last for last case
    a = array.first
    b = array.last
    c = array[(array.length)/2] if array.length % 2 == 1
    c =  array[(array.length)/2 - 1] if array.length % 2 == 0
    pivot_array = [a,b,c].sort
    return pivot_array[1]

  end
  
  def test_read#this si just for test
    puts @array
  end
  
end

q =QuickSort.new
q.quick_sort(q.array)
#q.quick_sort([3,9,8,4,6,10,2,5,7,1])
puts ""
print q.comparisons
#print q.partition([9,14,13,12,11,10,8,7,6], 9)
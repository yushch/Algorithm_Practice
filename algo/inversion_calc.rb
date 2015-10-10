class Inversions
  attr_accessor :number #设置公共变量
  
  def initialize
    @number = 0
    @array = array_set #读数组进去
    #print @array
  end
  
  def merge_find
    merge_sort(@array)
    print"there's #{@number} merges"
  end
  
  def array_set
    array = []
    File.open("IntegerArray.txt", "r") do |f|
      f.each_line do |num|
        array << num.to_i
        #break if array.length == 10
      end
    end
    return array
  end
  
  def merge_sort(array)
    return array if array.length <= 1
    num = (array.length)/2
    array_a = merge_sort(array[0..(num-1)])
    array_b = merge_sort(array[num..array.length])
    return merge(array_a, array_b)
  end
=begin #这种算法不可取，看上去好像很屌，但是stack levels too deep
  def merge(array1, array2)
    i = 0
    j = 0
    return array2 if array1.empty?
    return array1 if array2.empty?
    if array1.first < array2.first 
      array = [array1.first] + merge(array1[1..array1.length], array2)
    else
      @number += 1
      array = [array2.first] + merge(array2[1..array2.length], array1)
    end
    return array
  end
=end
    def merge(left, right)
      sorted = []
      until left.empty? || right.empty?
        if left.first < right.first
          sorted << left.shift
        else
          @number += left.length
          sorted << right.shift
        end
      end
      #@number += left.length unless left.empty?
      #@number += right.length unless right.empty?
      sorted.concat(left).concat(right)
    end
end

i = Inversions.new
i.merge_find


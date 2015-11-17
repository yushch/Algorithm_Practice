class KargerMinCut
    attr_accessor :vertex_array, :seed, :origin
    
    def initialize
        @vertex_array = {}
        @origin = {}
        File.open('kargerMinCut.txt').each_line do |line|
            line = line.split(" ")
            key = line.shift
            @origin[key] = line
            #@vertex_array.shuffle!
        end
        #@origin = @vertex_array
    end
    
    def prepare
       @vertex_array = @origin
       #@vertex_array = Hash[@vertex_array.to_a.shuffle]
    end
    
    def min_cut
       prepare
       key = rand(0..199).to_s
       #@seed = @vertex_array[key]
       merge(key)
       a =  @vertex_array.keys
       print a
    end
    
    def merge(key)
   
        @vertex_array.keys.each do |in_key|
           @vertex_array[key].each  do |item|
              @vertex_array[in_key].delete(item) if @vertex_array[in_key].include?(item) && in_key != key
           end
        end

        array = []
        
        @vertex_array[key].each do |index|
           array += @vertex_array[index] if @vertex_array[index]
           @vertex_array.delete(index)
           array.uniq! 
           @vertex_array[key] = array if @vertex_array.length == 2
           return @vertex_array if @vertex_array.length == 2
        end
        
        array.uniq!
        @vertex_array[key] = array
        upper = @vertex_array.length - 1
        key = rand(0..upper).to_s
        puts "ahh"
        merge(key)
    end
    
end

k = KargerMinCut.new
k.min_cut

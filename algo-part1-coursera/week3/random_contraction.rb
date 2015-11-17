class KargerMinCut
    attr_accessor :vertex_array, :reference
    
    def initialize
        @vertex_array = []
        @seed_array = []
        File.open('kargerMinCut.txt').each_line do |line|
            @seed_array = []
            line_array = line.split(" ").map {|num| num.to_i}
            (1).upto(line_array.length-1) do |index|
                @seed_array << line_array[index].to_i
            end
            @vertex_array << [[line_array[0].to_i], @seed_array]
        end
        @reference = @vertex_array
    end
    
    def min_cut
        @vertex_array = @reference
        connects = 0
        while(@vertex_array.length > 2) do
           min_cut_process
        end
        connects = @vertex_array[0][1].length
        
        return connects
    end
private
    def min_cut_process
        graph_begin = @vertex_array.sample
        graph_end = []
        target = 0
        target = graph_begin[1].sample 
        @vertex_array.each do |array|
           if array[0].include?(target)
               graph_end = array
               break
           end
        end
        graph_begin = merge(graph_begin, graph_end)
        @vertex_array.delete(graph_end)

    end
    
    def merge(graph_begin, graph_end)
       graph_begin[0] = (graph_begin[0] + graph_end[0])
       graph_begin[1] = (graph_begin[1] + graph_end[1])
       graph_begin[0].each do |begin_part|
          graph_begin[1].delete(begin_part) if graph_begin[1].include?(begin_part) 
       end
       return graph_begin
    end

end

a = KargerMinCut.new
c = []
10000.times do
    b = a.min_cut
    c << b
    p
end

print c.min







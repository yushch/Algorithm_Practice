class KosaNode
   attr_accessor :index, :value, :next, :explored
   
   def initialize(new_value)
          if(new_value == nil)
                @index = nil
                @value = nil
                @explored = false
                @next = [] 
          else
              @index = new_value[0]
              @value = new_value[0]
              @next = []
              @next << new_value[1]
              @explored = false
          end
   end
   
   def merge(edge)
      @next << edge[1] unless @next.include?(edge[1])
   end
    
end

class Kosaraju
    attr_accessor :graph, :graph_inv, :max, :now
    #
    def initialize
        @now = 1
        @max = 0
        @graph = []
        @graph_inv = []
        read_edge('minSCC2.txt')   #answer for minSCC should be 6,3,2,1,0 
        @graph.sort!{|n1,n2| n1.index <=> n2.index}
        @graph_inv.sort!{|n1,n2| n1.index <=> n2.index}
        #puts""
        find_top_five
        #print @graph_inv

    end
    
    def find_top_five
        top_five = [0, 0, 0, 0, 0]
        #value = 0
        #print top_five.min
        @max.downto(1) do |num|
            currentNode = find_node(@graph_inv, num)
            fDS(@graph_inv, currentNode) if currentNode.explored == false
        end
        1.upto(@max) do |index|
            current_inv = find_node(@graph_inv, index)
            current_reg = find_node(@graph, index)
            current_reg.value = current_inv.value
        end
        @max.downto(1) do |num|
            @now = 0
            currentNode = find_node_by_value(@graph, num)
            getMaxFDS(@graph, currentNode) if currentNode.explored == false
            #print value
            if (@now > top_five.min)
               top_five.delete_at(top_five.length-1)
               top_five << @now
               
               top_five.sort! {|a, b| b<=>a}
            end
        end
        print top_five
    end
    
    
    
private

    def find_node_by_value(graph, value)
       getNode = nil
       graph.each do |node|
           if node.value == value
              getNode = node
              break
           end
       end
       return getNode
    end
    
    def getMaxFDS(graph, currentNode)
        @now += 1
        currentNode.explored = true
        puts "doing the second DFS.........."
        #print"getMax start"+"\n"
        currentNode.next.each do |index|
           child_node = find_node(graph, index)
           if child_node.explored == false
               #print "now we explore inv index: #{index}, value: #{child_node.value}"+"\n"
               #max_value = [max_value, 
               getMaxFDS(graph, child_node)
               #].max
               #cyclic = false
           end
        end

    end
    
    def fDS(graph, currentNode)
        #cyclic = true
        currentNode.explored = true
        puts "doing the first DFS.........."
        currentNode.next.each do |index|
           child_node = find_node(graph, index)
           if child_node.explored == false
               #print "now we explore inv index: #{index}, value: #{child_node.value}"+"\n"
               fDS(graph, child_node)
               #cyclic = false
           end
        end
        
        #if cyclic == true
            currentNode.value = @now 
            @now += 1
        #end
    end
    
    def find_node(graph, index)
       getNode = nil
       graph.each do |node|
           if node.index == index
              getNode = node
              break
           end
       end
       return getNode
    end
    
    def read_edge(file)
       File.open(file).each_line do |line|
            temp_array = line.split(" ").map {|num| num.to_i}
            temp_array_inv = [temp_array[1], temp_array[0]]
            puts "reading file in......"
            merge_graph(@graph, temp_array)
            merge_graph(@graph_inv, temp_array_inv)
        end
    end

    def merge_graph(graph, temp_array)
        exist_u = false
        exist_v = false
        catch :graph_merge do
            graph.each do |node|
               if (node.index == temp_array[0] )
                   exist_u = true
                   node.merge(temp_array)
                   throw :graph_merge
               end
            end  
        end
        catch :graph_v_merge do
            graph.each do |node|
               if (node.index == temp_array[1] )
                   exist_v = true
                   throw :graph_v_merge
               end
            end 
        end
        if(exist_v == false)
           temp_kosa = KosaNode.new(nil)
           temp_kosa.index = temp_array[1]
           temp_kosa.value = temp_array[1]
           @max = [@max, temp_kosa.value].max
           graph << temp_kosa
        end
        
        if(exist_u == false)
           temp_kosa = KosaNode.new(temp_array)
           @max = [@max, temp_kosa.value].max
           graph << temp_kosa
        end

    end
    
    
    
    
end

a = Kosaraju.new
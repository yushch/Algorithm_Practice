def find_min_cuts(graph, trials)
  
  def contract(graph, node_1, node_2)
    # joins the two nodes' edges and eliminates self loops
    graph[node_1] = (graph[node_1] + graph[node_2])
    graph[node_1].delete(node_1)
    graph[node_1].delete(node_2)
    graph.delete(node_2)
    graph
  end
  
  
  def update_graph(graph, new_node, removed_node)
    # updates other nodes that previously connected to an eliminated node
    graph.values.each do |edges|
      edges.map! {|edge| edge == removed_node ? new_node : edge}
    end
    graph
  end
  
  
  def find_cuts(graph)
    if graph.length <= 2
      tmp = graph.values
      return [tmp[0].length, tmp[1].length].min 
    end 
    key1 = graph.keys.sample
    key2 = graph[key1].sample
    update_graph(graph, key1, key2)
    contract(graph, key1, key2)
    find_cuts(graph)
  end
  
  result = nil
  trials.times do
    tmp = Marshal.load(Marshal.dump(graph))
    current_cuts = find_cuts(tmp)
    if result.nil? || current_cuts < result
      result = current_cuts
    end
  end
  
  result 
end


input = {}
File.open('kargerMinCut.txt', 'r').each_line do |line|
  tmp = line.split.map {|n| n.to_i}
  input[tmp.shift] = tmp
end


puts find_min_cuts(input, 100)
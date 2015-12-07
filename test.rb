def find(key)
   if @hash.empty?
     answer = @hash
   elsif include?(key)
     puts "This KEY exists!"
   else
     answer = nil
   end
   answer
 end
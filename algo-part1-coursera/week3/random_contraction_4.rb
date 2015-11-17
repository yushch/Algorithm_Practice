class RC
    attr_accessor :value, :connection
    
   def initialize
       @value = 0
       @connection = []
   end
   
   def initialize(value, array)
       @value = value
       @connection = array
   end
   
   def merge(new_rc)
      @connection = @connection + new_rc.connection
      return new RC(@value, @connection)
   end
   
   def connect?(new_rc_value)
      return true if @connection.include?(value)
      return false
   end
end
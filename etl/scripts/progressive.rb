module Progressive
   def initialize(handle, options = {})
        @handle = handle
        @options = options
        @pb = @options[:progresses_with]
        @total = @options[:total]
        @format = '%t: |%B| %c/%C'
        @title  = "#{self.class.name}"
        @pb.reset
        super
   end

   def each
       @pb.format   = @format
       @pb.title    = @title
       @pb.progress = 0
       @pb.total    = self.class.count(@handle)
       super
   end

   def process(row)
       if (!@pb.nil? && @pb.progress == @pb.total)
           stop!
           @pb.reset
           @pb.progress = 0
           @pb.format = @format
           @pb.title = @title
           @pb.total = @total
        end
        progress!
        super
   end

   def progress!
       @pb.increment unless (@pb.nil? || @pb.progress == @pb.total)
   end

   def stop!
        puts ''
   end
end

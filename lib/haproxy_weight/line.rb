module HaproxyWeight
  # represents a line in an haproxy config file
  class Line
    def initialize(line)
      @line = line
    end

    def server_name
      return unless is_server_line?
      @line.match(/^(\s*)server (\w+)/)[2]
    end

    def weight
      @line =~ /weight (\d+)/ ? $1.to_i : nil
    end

    def weight=(new_weight)
      raise "weight must be an integer between 0 and 255" unless self.class.valid_weight?(new_weight)
      @line.sub!(/weight (\d+)/, "weight #{new_weight}")
    end

    def is_server_line?
      (@line =~ /^(\s*)server (\w+)/) != nil
    end

    def to_s
      @line
    end

    def self.valid_weight?(weight)
      return false unless weight.respond_to? :is_integer?
      return false unless weight.is_integer?
      (0..255).include? weight.to_i
    end
  end
end

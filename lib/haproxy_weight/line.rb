module HaproxyWeight
  # represents a line in an haproxy config file
  class Line
    def initialize(line)
      @line = line
    end

    def weight
      @line =~ /weight (\d+)/ ? $1.to_i : nil
    end

    def is_server_line?
      (@line =~ /^(\s*)server (\w+)/) != nil
    end

    def self.valid_weight?(weight)
      return false unless weight.respond_to? :is_integer?
      return false unless weight.is_integer?
      (0..255).include? weight.to_i
    end
  end
end

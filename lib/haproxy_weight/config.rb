require 'tempfile'

module HaproxyWeight
  class Config
    def initialize(filename)
      @filename = filename
      @lines = []

      File.open(@filename).each do |line|
        @lines << Line.new(line)
      end
    end

    def weights
      @lines.each do |line|
        next unless line.is_server_line?
        yield line.server_name, line.weight
      end
    end

    def set_weight(server_name, new_weight)
      @lines.each do |line|
        next unless line.server_name == server_name
        line.weight = new_weight
      end
    end

    def save
      tempfile = Tempfile.new('haproxy.cfg')
      tempfile.write(@lines.join("\n"))
      File.mv tempfile.path '/etc/haproxy/haproxy.cfg'
    end
  end
end

#open and read file
#modify file contents
#write to temp file
#move temp file to real location

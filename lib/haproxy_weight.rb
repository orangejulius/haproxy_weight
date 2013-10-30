require "haproxy_weight/version"

class String
  def is_integer?
    self.to_i.to_s == self
  end
end

class Fixnum
  def is_integer?
    true
  end
end

module HaproxyWeight
  def self.valid_weight?(weight)
    return false unless weight.respond_to? :is_integer?
    return false unless weight.is_integer?
    (0..255).include? weight.to_i
  end

  def self.find_weight_value(line)
    line =~ /weight (\d+)/ ? $1.to_i : nil
  end
end

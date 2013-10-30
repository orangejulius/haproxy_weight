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
  # Your code goes here...
  #
  def self.valid_weight?(weight)
    return false unless weight.respond_to? :is_integer?
    return false unless weight.is_integer?
    (0..255).include? weight.to_i
  end
end

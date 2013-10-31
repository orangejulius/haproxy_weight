require "haproxy_weight/line"
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
end

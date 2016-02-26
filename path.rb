class Path

  SHORTEST = -> (current, other) { current.length <=> other.length }
  CHEAPEST = -> (current, other) { current.total <=> other.total }

  attr_reader :links
  protected :links

  def initialize(links = [], total_strategy: CHEAPEST)
    @links = links
    @total_strategy = total_strategy
  end

  def ==(other)
    return false unless other.is_a? Path
    self.links == other.links
  end

  def <<(link)
    @links.unshift(link) if link
    self
  end

  def length
    @links.length
  end

  def total
    Link.total_cost(@links)
  end
end

class UnreachablePath

  UNREACHABLE = Float::INFINITY

  def <<(other)
    self
  end

  def total
    UNREACHABLE
  end

  def length
    UNREACHABLE
  end
end

class Path

  LENGTH_TOTAL = -> (links) { links.length }
  COST_TOTAL = -> (links) { Link.total_cost(links) }

  include Enumerable

  attr_reader :links
  protected :links

  def initialize(links = [], total_strategy: COST_TOTAL)
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

  def each(&block)
    @links.each(&block)
  end

  def <=>(other)
    self.total <=> other.total
  end

  def total
    @total_strategy.call(links)
  end
end

class UnreachablePath

  UNREACHABLE = Float::INFINITY

  def <=>(other)
    1
  end

  def <<(other)
    self
  end

  def total
    UNREACHABLE
  end
end

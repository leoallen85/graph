# Understands how to get from one node to another node
class Path

  SHORTEST = -> (champion, challenger) { champion.hop_count <=> challenger.hop_count }
  CHEAPEST = -> (champion, challenger) { champion.cost <=> challenger.cost }
  #LONGEST = -> (champion, challenger) { challenger.hop_count <=>
  #champion.hop_count }

  attr_reader :links
  protected :links

  def initialize(links = [])
    @links = links
  end

  def prepend(link)
    @links.unshift(link)
    self
  end

  def hop_count
    @links.length
  end

  def cost
    Link.total_cost(@links)
  end

  class UnreachablePath

    UNREACHABLE = Float::INFINITY

    def prepend(other)
      self
    end

    def cost
      UNREACHABLE
    end

    def hop_count
      UNREACHABLE
    end
  end

  NONE = UnreachablePath.new
end


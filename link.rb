# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

# Understands a way to reach a neighboring Node
class Link

  attr_reader :target, :cost
  private :target, :cost

  def self.total_cost(links)
    links.map { |link| link.send(:cost) }.inject(0, :+)
  end

  def initialize(target, cost)
    @target, @cost = target, cost
  end

  def _path(destination, visited_nodes, total_strategy)
    @target._path(destination, visited_nodes, total_strategy).prepend(self)
  end
end

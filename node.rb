# Copyright 2016 by Fred George. May be copied with this notice, but not used in classroom training.

require_relative './link'
require_relative './path'

# Understands it's neighbors
class Node

  def initialize
    @links = []
  end

  def >(neighbor_cost_pair)
    @links << Link.new(*neighbor_cost_pair)
    neighbor_cost_pair.first
  end

  def reach?(destination)
    _path(destination, no_visited_nodes, Path::CHEAPEST) != Path::NONE
  end

  def hop_count(destination)
    path_to(destination, Path::SHORTEST).hop_count
  end

  def cost(destination)
    path_to(destination, Path::CHEAPEST).cost
  end

  def path_to(destination, strategy = Path::CHEAPEST)
    result = _path(destination, no_visited_nodes, strategy)
    raise "Unreachable" if result == Path::NONE
    result
  end

  def _path(destination, visited_nodes, strategy)
    return Path.new if self == destination
    return Path::NONE if visited_nodes.include? self
    @links.map do |link|
      link._path(destination, visited_nodes.dup << self, strategy)
    end.min(&strategy) || Path::NONE
  end

  private

  def no_visited_nodes
    []
  end
end

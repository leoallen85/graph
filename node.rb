# Copyright 2016 by Fred George. May be copied with this notice, but not used in classroom training.

require_relative './link'
require_relative './path'

# Understands it's neighbors
class Node

  UNREACHABLE_PATH = UnreachablePath.new

  def initialize
    @links = []
  end

  def >(neighbor_cost_pair)
    @links << Link.new(*neighbor_cost_pair)
    neighbor_cost_pair.first
  end

  def reach?(destination)
    _path(destination, no_visited_nodes, Path::CHEAPEST) != UNREACHABLE_PATH
  end

  def hop_count(destination)
    path_to(destination, Path::SHORTEST).length
  end

  def cost(destination)
    path_to(destination, Path::CHEAPEST).total
  end

  def path_to(destination, total_strategy = Path::CHEAPEST)
    result = _path(destination, no_visited_nodes, total_strategy)
    raise "Unreachable" if result == UNREACHABLE_PATH
    result
  end

  def _path(destination, visited_nodes, total_strategy)
    return Path.new(total_strategy: total_strategy) if self == destination
    return UNREACHABLE_PATH if visited_nodes.include? self
    @links.map do |link|
      link._path(destination, visited_nodes.dup << self, total_strategy)
    end.min { |current, other| total_strategy.call(current, other) } || UNREACHABLE_PATH
  end

  private

  def no_visited_nodes
    []
  end
end

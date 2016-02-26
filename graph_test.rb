# Copyright 2016 by Fred George. May be copied with this notice, but not used in classroom training.

require 'minitest/autorun'
require_relative './node'

# Confirms behavior of graphical behaviors of Nodes
class GraphTest < Minitest::Test

  ('A'..'H').each { |label| const_set label.to_sym, Node.new }
  B > [A, 7]
  B > [C, 4] > [D, 5] > [E, 2] > [B, 3] > [F, 8] > [H, 9]
  C > [D, 1]
  C > [E, 6]

  def test_can_reach
    assert(A.reach? A)
    refute(A.reach? B)
    refute(G.reach? B)
    assert(B.reach? A)
    assert(C.reach? H)
    refute(B.reach? G)
  end

  def test_hop_count
    assert_equal(0, A.hop_count(A))
    assert_equal(1, B.hop_count(A))
    assert_equal(4, C.hop_count(H))

    assert_raises(RuntimeError) { A.hop_count(B) }
    assert_raises(RuntimeError) { G.hop_count(B) }
    assert_raises(RuntimeError) { B.hop_count(G) }
  end

  def test_cost
    assert_equal(0, A.cost(A))
    assert_equal(7, B.cost(A))
    assert_equal(23, C.cost(H))
    assert_raises(RuntimeError) { A.cost(B) }
    assert_raises(RuntimeError) { G.cost(B) }
    assert_raises(RuntimeError) { B.cost(G) }
  end

  def test_path_to
    assert_path(0, 0, A, A)
    assert_path(1, 7, B, A)
    assert_path(5, 23, C, H)
    assert_raises(RuntimeError) { A.path_to(B) }
    assert_raises(RuntimeError) { G.path_to(B) }
    assert_raises(RuntimeError) { B.path_to(G) }
  end

  private

  def assert_path(expected_hop_count, expected_cost, source, destination)
    path = source.path_to(destination)
    assert_equal(expected_hop_count, path.hop_count)
    assert_equal(expected_cost, path.cost)
  end
end

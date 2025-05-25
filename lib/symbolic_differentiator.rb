require_relative 'symbolic_differentiator/version'
require_relative 'symbolic_differentiator/differentiator'

module SymbolicDifferentiator
  def self.differentiate(expression, variable)
    PolynomialDifferentiator.differentiate(expression, variable)
  end
end

require 'spec_helper'
require 'symbolic_differentiator'

describe SymbolicDifferentiator do
  describe '.differentiate' do
    it 'differentiates x^2+4x+3+y with respect to x' do
      result = SymbolicDifferentiator.differentiate("x^2+4*x+3+y", 'x')
      expect(result).to eq("2*x+4")
    end

    it 'handles negative coefficients' do
      result = SymbolicDifferentiator.differentiate("-x^2", 'x')
      expect(result).to eq("-2*x")
    end

    it 'handles multiple terms and simplifies' do
      result = SymbolicDifferentiator.differentiate("3*x^4-2*x^3+x", 'x')
      expect(result).to eq("12*x^3-6*x^2+1")
    end

    it 'returns 0 for constants' do
      expect(SymbolicDifferentiator.differentiate("5", 'x')).to eq("0")
    end
  end
end
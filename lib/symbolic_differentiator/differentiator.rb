module SymbolicDifferentiator
    class PolynomialDifferentiator
      def self.differentiate(expression, var)
        terms = split_terms(expression)
        differentiated_terms = terms.map { |term| process_term(term, var) }.compact
        combine_terms(differentiated_terms)
      end
  
      private
  
      def self.split_terms(expression)
        expr = expression.gsub(/\s/, '')
        expr.split(/(?=[+-])/).map { |t| t.empty? ? '+0' : t }
      end
  
      def self.process_term(term, var)
        parsed = parse_term(term)
        diff_info = differentiate_term(parsed, var)
        return nil if diff_info.nil? || diff_info[:coefficient] == 0
        term_to_s(diff_info)
      end
  
      def self.parse_term(term)
        term = term.dup.gsub(/\s/, '')
        sign = term.start_with?('-') ? -1 : 1
        term.sub!(/^[+-]/, '')
        
        coefficient = 1.0
        variables = {}
      
        coeff_match = term.match(/^(\d+\.?\d*|\d*\.?\d+)/)
        if coeff_match && !coeff_match[0].empty?
          coefficient = coeff_match[0].to_f
          term = term[coeff_match[0].size..-1]
        end
      
        until term.empty?
          var_match = term.match(/^\*?([a-z])(\^(\d+))?/)
          break unless var_match
      
          var = var_match[1]
          exponent = var_match[3] ? var_match[3].to_i : 1
          variables[var] ||= 0
          variables[var] += exponent
      
          term = term[var_match[0].size..-1]
        end
      
        { coefficient: coefficient * sign, variables: variables }
      end
  
      def self.term_to_s(term)
        return '' if term[:coefficient] == 0
      
        parts = []
        coeff = term[:coefficient]
        int_coeff = coeff.to_i
        display_coeff = (coeff == int_coeff) ? int_coeff : coeff.round(2)
      
        parts << display_coeff unless display_coeff == 1 && !term[:variables].empty?
        parts << '-' if display_coeff == -1 && !term[:variables].empty?
      
        term[:variables].sort.each do |var, exp|
          part = var.to_s
          part += "^#{exp}" if exp > 1
          parts << part
        end
      
        str = parts.join('*')
        str.sub(/^-/, '') + (str.start_with?('-') ? " - #{str[1..-1]}" : '')
      end
    end
  end
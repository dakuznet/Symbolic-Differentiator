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


      def self.differentiate_term(term_info, var)
        return nil unless term_info[:variables].key?(var)
  
        new_coeff = term_info[:coefficient] * term_info[:variables][var]
        new_vars = term_info[:variables].dup
        new_vars[var] > 1 ? new_vars[var] -= 1 : new_vars.delete(var)
  
        new_vars.empty? ? { coefficient: new_coeff, variables: {} } : { coefficient: new_coeff, variables: new_vars }
      end
  
      def self.term_to_s(term)
        return '' if term[:coefficient] == 0
  
        coeff = term[:coefficient]
        vars = term[:variables]
  
        display_coeff = if coeff == 1 && !vars.empty?
                          nil
                        elsif coeff == -1 && !vars.empty?
                          '-'
                        else
                          coeff.to_i == coeff ? coeff.to_i : coeff.round(2)
                        end
  
        var_str = vars.sort.map do |var, exp|
          exp > 1 ? "#{var}^#{exp}" : var
        end.join('*')
  
        parts = [display_coeff, var_str].compact
        return '0' if parts.empty?
        parts.join('*').gsub(/\*+$/, '')
      end

      def self.combine_terms(terms)
        grouped = Hash.new(0)
        terms.each do |term_str|
          term = parse_term(term_str)
          key = term[:variables]
          grouped[key] += term[:coefficient]
        end
  
        combined = grouped.each_with_object([]) do |(vars, coeff), arr|
          next if coeff.zero?
          arr << term_to_s({ coefficient: coeff, variables: vars })
        end
  
        combined.empty? ? '0' : combined.join('+').gsub('+-', '-')
      end

    end
  end
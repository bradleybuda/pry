class Pry
  Pry::Commands.create_command "jump-to" do
    group 'Navigating Pry'
    description "Jump to a binding further up the stack, popping all " \
      "bindings below."

    def process(break_level)
      break_level = break_level.to_i
      nesting_level = _pry_.binding_stack.size - 1

      case break_level
      when nesting_level
        output.puts "Already at nesting level #{nesting_level}"
      when (0...nesting_level)
        _pry_.binding_stack.slice!(break_level + 1, _pry_.binding_stack.size)

      else
        max_nest_level = nesting_level - 1
        output.puts "Invalid nest level. Must be between 0 and #{max_nest_level}. Got #{break_level}."
      end
    end
  end
end

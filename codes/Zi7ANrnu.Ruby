class Module
  def def_t(name, **sig, &block)
    names = sig.keys
    types = sig.values
    type_check = ->(args) { types.size == args.size && types.zip(args).all? { |t, v| t === v } }
    define_method(name) do |*args|
      if type_check.call(args)
        names.zip(args) { |name, value| block.binding.local_variable_set(name, value) }
        instance_eval(&block)
      else
        raise TypeError
      end
    end
  end
end

class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def_t :greet, name: String do
    puts self.name
    puts @name
    puts name
  end
end

Person.new('Taro').greet('Jiro')
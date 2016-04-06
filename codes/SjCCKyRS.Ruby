module Life
  class Person
#    attr :age
#    attr :name
    getter age
    getter name

    def initialize(name, age)
      @name = name
      @age = age
    end

    def +(other)
      Marriage.new self, other
    end
  end

  class Marriage
    def initialize(a, b)
      @a = a
      @b = b
    end

    def announce
      puts "#{@a.name} married #{@b.name}!"
    end
  end
end

a = Life::Person.new "a", 30
b = Life::Person.new "b", 30

m = a + b
m.announce
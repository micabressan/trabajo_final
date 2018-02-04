#
# Fancy, short, lexicographically sortable, self-identifying, globally unique, model ids
# for Sequel <3
#
# cf. https://github.com/oklog/ulid
#
class Sequel::Model
  def self.inherited(subclass)
    prefix = subclass.name[0].downcase
    subclass.name.chars.each_with_index do |l, i|
      next if %w[a e i o u].include? l
      next if 0 == i
      prefix << l.downcase
      break
    end
    prefix << subclass.name[-1].downcase
    if MODEL_BY_PREFIX.include? prefix
      raise ZeroDivisionError, "Model ID prefix '#{prefix}' conflict between #{MODEL_BY_PREFIX[prefix]} and #{subclass.name}"
    end
    subclass.const_set('ID_PREFIX', prefix)
    MODEL_BY_PREFIX[prefix] = subclass

    super
  end

  def before_create
    super
    self[:id] = (self.class.const_get('ID_PREFIX') + ULID.generate).downcase
  end
end

class User << Sequel::Model; end
class Comment << Sequel::Model; end

# Gives you IDs such as:
# usr1q1rk4mkc5adzh9m8vdtg30qhg
# cmt5k93l360j23tejewt94j5w95j9
# ...
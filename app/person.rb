class Person
  attr_accessor :person_name, :expected_raise

  def initialize()
    @person_name = 'New Person'
    @expected_raise = 0.0
  end

  def setNilValueForKey(key)
    if key == 'expected_raise'
      @expected_raise = 0.0
    else
      super
    end
  end

  def setValue(v, forKey: k)
    if v == nil && k == 'person_name'
      @person_name = ''
    else
      super(v, forKey: k)
    end
  end

  def initWithCoder(coder)
    self.person_name = coder.decodeObjectForKey('person_name')
    self.expected_raise = coder.decodeFloatForKey('expected_raise')
  end

  def encodeWithCoder(coder)
    coder.encodeObject(person_name, forKey: 'person_name')
    coder.encodeFloat(expected_raise, forKey: 'expected_raise')
  end
end

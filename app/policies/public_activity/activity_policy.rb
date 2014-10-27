class PublicActivity::ActivityPolicy
  attr_reader :person, :record

  def initialize(person, record)
    @person = person
    @record = record
  end

  def activities?
    @person.user? || @person.manager? || @person.admin?
  end

end

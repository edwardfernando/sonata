class PersonPolicy
  attr_reader :person, :record

  def initialize(person, record)
    @person = person
    @record = record
  end

  def index?
    @person.admin?
  end

  def update?
    @person.admin?
  end

  def destroy?
    @person.admin?
  end

end

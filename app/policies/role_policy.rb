class RolePolicy
  attr_reader :person, :record

  def initialize(person, record)
    @person = person
    @record = record
  end

  def index?
    @person.admin?
  end

  def new?
    @person.admin?
  end

  def create?
    @person.admin?
  end

  def edit?
    @person.admin?
  end

  def update?
    @person.admin?
  end

  def destroy?
    @person.admin?
  end

  def show?
    @person.admin?
  end

end

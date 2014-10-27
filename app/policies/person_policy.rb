class PersonPolicy
  attr_reader :person, :record

  def initialize(person, record)
    @person = person
    @record = record
  end

  def index?
    @person.user? || @person.manager? || @person.admin?
  end

  def approve?
    @person.manager? || @person.admin?
  end

  def new?
    @person.manager? || @person.admin?
  end

  def create?
    @person.manager? || @person.admin?
  end

  def edit?
    @person.manager? || @person.admin?
  end

  def update?
    @person.manager? || @person.admin?
  end

  def destroy?
    @person.manager? || @person.admin?
  end

  def show?
    @person.manager? || @person.admin?
  end

  def popup_people?
    @person.manager? || @person.admin?
  end

  def update_level?
    @person.admin?
  end

end

class ServicePolicy
  attr_reader :person, :record

  def initialize(person, record)
    @person = person
    @record = record
  end

  def index?
    puts "service_policy_index"
    @person.user? || @person.manager? || @person.admin?
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

end

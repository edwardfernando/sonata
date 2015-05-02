class ServicePolicy
  attr_reader :person, :record

  def initialize(person, record)
    @person = person
    @record = record
  end

  def index?
    @person.user? || @person.manager? || @person.admin?
  end

  def show_new_calendar?
    @person.user? || @person.manager? || @person.admin?
  end

  def calendar_feed_events?
    @person.user? || @person.manager? || @person.admin?
  end

  def show?
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

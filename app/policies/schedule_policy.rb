class SchedulePolicy
  attr_reader :person, :record

  def initialize(person, record)
    @person = person
    @record = record
  end

  def create?
    @person.manager? || @person.admin?
  end

  def confirm?
    person.id == record.person.id
  end

  def reject?
    person.id == record.person.id
  end

  def destroy?
    @person.manager? || @person.admin?
  end

  def direct_action?
    true
  end

  def confirm_from_email?
    true
  end

  def reject_from_email?
    true
  end
end

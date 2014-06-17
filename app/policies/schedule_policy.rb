class SchedulePolicy
  attr_reader :person, :record

  def initialize(person, record)
    @person = person
    @record = record
  end

  def confirm?
    person.id == record.person.id
  end

  def reject?
    person.id == record.person.id
  end
end

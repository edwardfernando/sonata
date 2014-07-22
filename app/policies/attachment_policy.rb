class AttachmentPolicy
  attr_reader :person, :record

  def initialize(person, record)
    @person = person
    @record = record
  end

  def destroy?
    @person.manager? || @person.admin?
  end
end

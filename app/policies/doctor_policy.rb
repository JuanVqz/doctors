class DoctorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError unless user.admin?
      scope.all
    end
  end

  def show?
    user.admin?
  end

  def create?
    user.admin? && user.hospital.medium?
  end

  def new?
    create?
  end

  def update?
    show?
  end

  def edit?
    show?
  end
end

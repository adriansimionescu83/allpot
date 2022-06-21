class ProfilePolicy < ApplicationPolicy
  def update?
    true
  end

  def show?
    true
  end
end

class RecipePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  def show?
    true
  end

  def cooked?
    true
  end

  def my_recipes?
    true
  end

  def back?
    true
  end
end

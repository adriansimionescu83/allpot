class IngredientPolicy < ApplicationPolicy
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
    return true
  end

  def build_shopping_list?
    true
  end

  def shopping_list?
    true
  end

  def move_to_pantry?
    true
  end
end

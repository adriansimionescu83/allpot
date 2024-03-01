require 'faraday'
require 'faraday/net_http'

Faraday.default_adapter = :net_http

class CallSpoonacular

  def self.get_recipes(ingredients, current_user)
    api_key = ENV["SPOONTACULAR_API_KEY"]
    conn = Faraday.new(
      url: 'https://api.spoonacular.com/recipes',
      params: {apiKey: api_key},
      headers: {'Content-Type' => 'application/json'}
    )

    response = conn.get('complexSearch', {
      includeIngredients: ingredients,
      addRecipeInformation: true,
      sort: 'max-used-ingredients',
      sortDirection: 'desc',
      fillIngredients: true,
      diet: current_user.diet.nil? ? '' : current_user.diet.join(',').downcase,
      intolerances: current_user.intolerances.nil? ? '' : current_user.intolerances.join(',').downcase,
      ignorePantry: false
      })

    return JSON.parse(response.body)["results"] #recipes
  end
end

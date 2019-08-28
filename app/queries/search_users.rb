class SearchUsers
  attr_reader :params
  def initialize(params = {})
    @params = params
    @scope = User.where(status: "active")
  end

  def call
    @scope = filter_by_text(@scope, params[:query]) if params[:query].present?
    @scope = filter_by_location(@scope, params[:location]) if params[:location].present?
    @scope
  end

  private

  def filter_by_text(scope, text)
    scope.search_user_fields(text)
  end

  def filter_by_location(scope, location)
    scope.near(location, 10)
  end
end

# frozen_string_literal: true

class SearchFormComponent < ViewComponent::Base
  def initialize(search_path:, placeholder:)
    @search_path = search_path
    @placeholder = placeholder
  end

  private

  attr_reader :search_path, :placeholder
end

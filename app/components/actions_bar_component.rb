# frozen_string_literal: true

class ActionsBarComponent < ViewComponent::Base
  def initialize(subject:, search: true)
    @subject = subject
    @search = search
  end

  def text
    "Registrar #{placeholder}"
  end

  def placeholder
    I18n.t("activerecord.model.#{subject}")
  end

  def search_path
    [subject.to_s.pluralize.to_sym]
  end

  def search?
    @search
  end

  private

  attr_reader :subject
end

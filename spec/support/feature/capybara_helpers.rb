# frozen_string_literal: true

def fill_in_trix_editor(id, with:)
  find(:xpath, "//trix-editor[@input='#{id}']").click.set(with)
end

def expect_combobox(query, value:)
  expect(find(query, visible: false).value).to eq value
end

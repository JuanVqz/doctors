def fill_in_trix_editor id, with:
  find(:xpath, "//trix-editor[@input='#{id}']").click.set(with)
end

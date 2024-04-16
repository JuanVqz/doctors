# frozen_string_literal: true

def expect_combobox(selector, value:)
  expect(find(selector, visible: false).value).to eq value
end

def delete_from_combobox(selector, text, original:)
  find(selector).then do |input|
    original.chars.each { input.send_keys(:arrow_right) }
    text.chars.each { input.send_keys(:backspace) }
  end
end

def click_on_option(text)
  find('li[role=option]', exact_text: text).click
end

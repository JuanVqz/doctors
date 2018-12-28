module Feature
  module SharedMethodsHelpers
    def click_link_details
      find('a[data-tooltip="Detalles"]').click
    end
  end
end

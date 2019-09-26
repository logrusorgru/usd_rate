require "application_system_test_case"

class RatesTest < ApplicationSystemTestCase
  setup do
    @rate = rates(:one)
  end

  test "updating a Rate" do
    visit admin_path
    click_on "Изменить", match: :first

    fill_in "Курс:", with: @rate.rate
    fill_in "До:", with: @rate.overwrite
    click_on "Изменить"

    assert_text "Курс успешно изменён"
    click_on "Назад"
  end

end

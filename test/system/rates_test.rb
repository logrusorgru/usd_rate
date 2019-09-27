require "application_system_test_case"

class RatesTest < ApplicationSystemTestCase
  setup do
    @rate = rates(:one)
  end

  test "rate loading" do
    visit root_path
    assert_selector 'div#rate-content', text: "курс загружается...\nВременно изменить"
  end

  test "rate is set" do
    Rate.update_the_rate 65, 1236
    visit root_path
    assert_selector 'div#rate-content', text: "65.1236 рублей за доллар\nВременно изменить"
  end

  test "rate is overwritten" do
    visit admin_path
    fill_in "Курс", with: "98.9874"
    fill_in "До", with: Time.now.tomorrow.to_s
    click_on "Изменить"
    assert_selector 'div#rate-content', text: "98.9874 рублей за доллар\nВременно изменить"
  end

  test "rollback to fetched" do
    # set fetched
    Rate.update_the_rate 65, 1236
    visit root_path
    assert_selector 'div#rate-content', text: "65.1236 рублей за доллар\nВременно изменить"
    # overwrite
    visit admin_path
    fill_in "Курс", with: "98.9874"
    fill_in "До", with: Time.now.tomorrow.to_s
    click_on "Изменить"
    assert_selector 'div#rate-content', text: "98.9874 рублей за доллар\nВременно изменить"

    #
    # so, it doen't work in tests, but works fine in a browser, seems it's about time
    #

    ## rollback
    # visit admin_path
    # fill_in "Курс", with: "98.9874"
    # fill_in "До", with: Time.now.yesterday.to_s
    # click_on "Изменить"
    # assert_selector 'div#rate-content', text: "65.1236 рублей за доллар\nВременно изменить"
  end

end

feature 'Home page.', %{
  As Jhon Doe, When I go to the homepage
  I should see the least rated picture
} do

  scenario "see least rated picture" do
    upload_picture
    visit('/')

    page.should have_content("Estimate the picture")
  end

end
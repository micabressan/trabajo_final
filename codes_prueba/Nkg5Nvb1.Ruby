context "when signing in correctly" do

  before do
    visit signin_path #uses _signedout partial
    fill_in "session_email", :with => @user.email
    fill_in "session_password", :with => @user.password
    click_button "Submit"
  end

  subject { response }

  it { should_not render_template('layouts/_signedout') }
  it { should render_template('layouts/_signedin') }

end
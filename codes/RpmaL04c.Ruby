class UsersController < ApplicationController
  skip_before_action :auth_user!, except: [:update]
  before_action :reject_current_user!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      login_user! @user
      generate_start_data
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    return update_settings if settings_params.present?

    unless current_user.update user_params.except(:settings)
      flash[:error] = current_user.errors.full_messages.first
    end

    redirect_to profile_path
  end

  private

  def reject_current_user!
    redirect_to :root if current_user.present?
  end

  def generate_start_data
    StartDataCreator.new(current_user).create_data!
  end

  def update_settings
    session[:minimized_list] = settings_params[:minimized_list].present?
    head :ok
  end

  def settings_params
    user_params[:settings]
  end

  def user_params
    params.require(:user).permit \
      :username, :email,
      :password, :password_confirmation, :old_password,
      settings: [:minimized_list]
  end
end


describe UsersController do
  let(:old_username) { 'Ayn Rand' }
  let(:old_email) { 'ayn@rand.com' }

  let!(:user) do
    create :user, username: old_username, email: old_email
  end

  subject { response }

  context 'when user is logged in' do
    before { login user }

    describe 'GET new' do
      before { get :new }
      it { is_expected.to redirect_to(root_path) }
    end

    describe 'POST create' do
      before { post :create }
      it { is_expected.to redirect_to(root_path) }
    end

    describe 'PUT update' do
      let(:dispatch) { put :update, params: {id: user.id, user: params} }
      let(:params) { {email: email, username: username} }

      context 'when params are valid' do
        let(:email) { 'some_valid@email.com' }
        let(:username) { 'newman' }

        it { is_expected.to be_success }
        it do
          expect { dispatch }.to change { user.reload.username }.to username
        end
      end

      context 'when params are invalid' do
        let(:email) { '' }
        let(:username) { '' }

        it { is_expected.to be_success }
        it { expect { dispatch }.not_to change { user.reload.username } }
      end
    end
  end

  context 'when user is not logged in' do
    describe 'GET new' do
      before { get :new }
      it { is_expected.to be_success }
    end

    describe 'POST create' do
      before { post :create, params: {user: params} }
      let(:params) { { email: email, password: password, username: username } }

      context 'when params are valid' do
        let(:email) { 'some_valid@email.com' }
        let(:password) { 'valid password' }
        let(:username) { 'newman' }

        it { is_expected.to redirect_to(root_path) }

        it 'changes current_user to the new one' do
          expect(assigns(:current_user).email).to eq(email)
          expect(assigns(:current_user)).not_to be_instance_of(GuestUser)
        end
      end

      context 'when params are invalid' do
        let(:email) { '' }
        let(:password) { '' }
        let(:username) { '' }

        it { is_expected.to be_success }

        it 'doesnt change the guest user' do
          expect(assigns(:current_user)).to be_instance_of(GuestUser)
        end
      end
    end

    describe 'PUT update' do
      before { put :update, params: {id: user.id} }
      it { is_expected.to redirect_to(login_path) }
    end
  end
end
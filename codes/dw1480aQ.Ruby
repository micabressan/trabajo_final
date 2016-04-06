require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  describe 'GET #new' do
    before(:each) do
      get :new
    end

    it 'renders the #new view' do
      assert_response :success
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new account' do
        expect { create_valid_account } .to change(Account, :count).by(1)
        assert_response :redirect
      end

      it 'redirects to the new account' do
        create_valid_account
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid params' do
      it 'does not save the new account' do
        expect { create_invalid_account } .to_not change(Account, :count)
      end

      it 're-renders the new view' do
        create_invalid_account
        expect(response).to render_template :new
      end
    end
  end

  def create_valid_account
    post :create, account: FactoryGirl.attributes_for(:account)
  end

  def create_invalid_account
    post :create, account: FactoryGirl.attributes_for(:invalid_account)
  end
end
# this class is intended to manage user's session
# it creates and destroys cookies and makes appropriate changes to the database
class UserAttendance
  attr_reader :user

  def initialize(request,
                 user = nil,
                 session_klass = Session)
    @request = request
    @session = request.session
    @user    = user
    @session_klass = session_klass
  end

  # - reads user's session token
  # - searches appropriate session, based on that token
  # - gets the session related user
  def find_user
    user_session = find_sessions
    return unless user_session.present?
    user_session.user
  end

  # - terminates old sessions
  # - creates new session object for an user
  # - writes token to cookies
  def login!
    return unless @user.present?

    terminate_same_sessions
    @session.update session_token: create_new_session.token
    @user
  end

  # - searches for existing session in the database
  # - deactivates it if it presents
  # - clears user's cookies
  def logout!
    return unless @user.present?
    user_session = find_session_for_logout
    return unless user_session.present?

    user_session.deactivate!
    @session.update session_token: nil
    @user
  end

  private

  def token_from_session
    @token_from_session ||= @session.fetch(:session_token, nil)
  end

  def find_session_for_logout
    return unless token_from_session.present?
    @session_klass.find_for_logout \
      token_from_session, @user, @request
  end

  def find_sessions
    return unless token_from_session.present?
    @session_klass.find_for_auth token_from_session, @request
  end

  def terminate_same_sessions
    @session_klass.terminate_all_for_user @user, @request
  end

  def create_new_session
    @session_klass.create \
      user:  @user,
      ip_address: @request.remote_ip,
      user_agent: @request.user_agent
  end
end

describe UserAttendance do
  let(:user) { create :user }
  let(:session) { create :session, user: user }
  let(:user_token) { session.token }
  let(:session_token) { session.token }
  let(:ip) { session.ip_address }
  let(:user_agent) { session.user_agent }
  let(:request) do
    double \
      'request',
      session: {session_token: session_token},
      remote_ip:  ip,
      user_agent: user_agent
  end

  describe '#find_user' do
    subject { described_class.new request }

    context 'when user with token from session exists' do
      it 'returns user from session' do
        expect(subject.find_user).to eq(user)
      end
    end

    context 'when there is no user with token from session' do
      let(:session_token) { 'another token' }

      it 'returns nil' do
        expect(subject.find_user).to be_nil
      end
    end
  end

  describe '#login!' do
    let(:session_token) { 'token' }
    let(:ip) { '0.0.0.0' }
    let(:user_agent) { 'webkit' }

    subject { described_class.new request, user }

    it 'creates new session for user' do
      expect { subject.login! }.to change { Session.count }.by(1)
    end

    it 'writes token to cookie session' do
      expect { subject.login! }.to change { request.session[:session_token] }
    end
  end

  describe '#logout!' do
    subject { described_class.new request, user }

    it 'deactivate user\'s session' do
      expect { subject.login! }
        .to change { session.reload.outdated }
        .from(false).to(true)
    end

    it 'clear cookie session token' do
      expect { subject.logout! }
        .to change { request.session[:session_token] }
        .from(session_token).to(nil)
    end
  end
end
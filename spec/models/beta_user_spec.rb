require 'spec_helper'

describe BetaUser do
  let(:active_beta){ create :beta_user, active: true }
  let(:beta){ create :beta_user }
  describe 'when saving' do
    it 'downcase the user' do
      BetaUser.create(username: 'ThisUser',email: 'this@email.com')
      BetaUser.last.username.should == 'thisuser'
    end
  end

  describe '.can_login?' do
    describe 'when is active' do
      subject{ create :beta_user, active: true }

      it 'true when username was added' do
        BetaUser.can_login?(subject.username.split('/').last)
          .should be_true
      end

      it 'false when there is no user found' do
        BetaUser.can_login?('invalid username')
          .should be_false
      end
    end

    describe 'when is not active' do
      subject{ create :beta_user, active: false }

      it 'true when username was added' do
        BetaUser.can_login?(subject.username.split('/').last)
          .should be_false
      end

      it 'false when there is no user found' do
        BetaUser.can_login?('invalid username')
          .should be_false
      end
    end
  end
end


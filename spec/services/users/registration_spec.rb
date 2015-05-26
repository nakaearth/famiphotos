require 'rails_helper'

module Users
  describe Registration do
    let(:user) { create(:user) }

    describe 'twitter登録処理を追加' do
      subject { Users::Registration.new.regist(auth) }

      let(:auth) do
        { provider: 'twitter', uid: uid,
          info: { name: name, email: email },
          extra: { raw_info:
            { nickname: 'hoge user', image: 'http://test.jp/tes.jpg' }
        },
          credentials: { token: '123aabbccdd', secret: 'aabb123' }
        }
      end

      context 'twitterアカウントの登録' do
        let(:uid) { '11223344aaaa' }
        let(:email) { 'test@gmail.com' }
        let(:name) { 'test user' }

        it 'ユーザが登録される' do
          is_expected.not_to be_nil
          expect(subject.email).to eq('test@gmail.com')
        end
      end

      context '既に登録済みの場合' do
        let(:email) { user.email }
        let(:uid) { user.uid }
        let(:name) { user.name }

        it '既に登録済みのユーザ情報を返す' do
          expect(subject.email).to eq(user.email)
          expect(subject.name).to eq(user.name)
        end
      end
    end
  end
end

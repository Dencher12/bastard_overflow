require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:answer) { build(:answer, user: user) }
  let(:question) { create(:question, user: user) }

  describe 'POST #create' do
    sign_in

    context 'valid' do
      let(:attr) { attributes_for(:answer) }

      it 'saves new answer in the db' do
        expect { post :create, params: { answer: attr, question_id: question.id } }.to change(Answer, :count).by(1) 
      end

      it 'redirects to show view of question' do
        post :create, params: { answer: attr, question_id: question.id }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'invalid' do
      let(:attr) { attributes_for(:invalid_answer) }

      it 'does not save new answer in the db' do
        expect { post :create, params: { answer: attr, question_id: question.id } }.to_not change(Answer, :count)
      end

      it 'renders the edit view' do
        post :create, params: { answer: attr, question_id: question.id }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
  end
end

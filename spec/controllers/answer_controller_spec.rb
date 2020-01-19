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
        expect { post :create, params: { answer: attr, question_id: question.id }, format: :js }.to change(question.answers, :count).by(1) 
      end

      it 'renders create template' do
        post :create, params: { answer: attr, question_id: question.id }, format: :js
        expect(response).to render_template :create
      end
    end

    context 'invalid' do
      let(:attr) { attributes_for(:invalid_answer) }

      it 'does not save new answer in the db' do
        expect { post :create, params: { answer: attr, question_id: question.id }, format: :js }.to_not change(Answer, :count)
      end

      it 'renders create template' do
        post :create, params: { answer: attr, question_id: question.id }, format: :js
        expect(response).to render_template :create
      end
    end
  end
end

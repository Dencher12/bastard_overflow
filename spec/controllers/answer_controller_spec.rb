require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  describe 'POST #create' do
    sign_in

    context 'valid' do
      let(:attr) { attributes_for(:answer) }

      it 'saves new answer in the db' do
        expect { post :create, params: { answer: attr, question_id: question.id }, format: :js }.to change(question.answers, :count).by(1) 
      end

      it 'renders create template' do
        post :create, params: { answer: attr, question_id: question.id }, format: :js
        expect(response).to render_template 'answers/_answer'
      end
    end

    context 'invalid' do
      let(:attr) { attributes_for(:invalid_answer) }

      it 'does not save new answer in the db' do
        expect { post :create, params: { answer: attr, question_id: question.id }, format: :js }.to_not change(Answer, :count)
      end

      it 'renders create template' do
        post :create, params: { answer: attr, question_id: question.id }, format: :js
        expect(response).to_not render_template 'answers/_answer'
      end
    end
  end

  describe 'PATH #edit' do
    let(:attr) { attributes_for(:answer) }

    sign_in

    it 'finds answer by id and assigns to a variable' do
      patch :update, params: { id: answer.id, answer: attr, question_id: question.id }, format: :js
      expect(assigns(:answer)).to eq(answer)
    end

    it 'changes answer attr' do
      patch :update, params: { id: answer.id, answer: { body: 'new body' }, question_id: question.id }, format: :js
      answer.reload
      expect(answer.body).to eq('new body')
    end
  end
end

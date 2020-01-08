require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:answer) { build(:answer) }
  let(:question) { create(:question) }
  describe 'GET #index' do
    let(:answers) { build_list(:answer, 2) }

    before do
      question.answers = answers
      question.save
      get :index, params: { question_id: question.id }
    end

    it 'fills array of all answers' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before do
      question.answers << answer
      question.save
      get :show, params: { id: answer.id, question_id: question.id }
    end

    it 'finds answer by id and assigns to a variable' do
      expect(assigns(:answer)).to eq(answer)
    end

    it 'renders index view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new, params: { question_id: question.id } }

    it 'creates answer and assigns to a variable' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'valid' do
      let(:attr) { attributes_for(:answer) }

      it 'saves new answer in the db' do
        expect { post :create, params: { answer: attr, question_id: question.id } }.to change(Answer, :count).by(1) 
      end

      it 'redirects to show view' do
        post :create, params: { answer: attr, question_id: question.id }
        expect(response).to redirect_to question_answer_path(assigns(:question), assigns(:answer))
      end
    end

    context 'invalid' do
      let(:attr) { attributes_for(:invalid_answer) }

      it 'does not save new answer in the db' do
        expect { post :create, params: { answer: attr, question_id: question.id } }.to_not change(Answer, :count)
      end

      it 'renders the edit view' do
        post :create, params: { answer: attr, question_id: question.id }
        expect(response).to render_template :edit
      end
    end
  end
end

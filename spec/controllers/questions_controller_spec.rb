require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2, user: user) }

    before do
      get :index
    end

    it 'fills array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: question.id }
    end

    it 'finds question by id and assigns to a variable' do
      expect(assigns(:question)).to eq(question)
    end

    it 'renders index view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in
    before { get :new }

    it 'creates question and assigns to a variable' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in

    context 'valid' do
      let(:attr) { attributes_for(:question) }

      it 'saves new question in the db' do
        expect { post :create, params: { question: attr } }.to change(Question, :count).by(1) 
      end

      it 'redirects to show view' do
        post :create, params: { question: attr }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'invalid' do
      let(:attr) { attributes_for(:invalid_question) }

      it 'does not save new question in the db' do
        expect { post :create, params: { question: attr } }.to_not change(Question, :count)
      end

      it 'renders the new view' do
        post :create, params: { question: attr }
        expect(response).to render_template :new
      end
    end
  end
end

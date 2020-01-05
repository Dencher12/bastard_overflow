require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { FactoryBot.create(:question) }

  describe 'GET #index' do
    let(:questions) { FactoryBot.create_list(:question, 2) }

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
    before { get :new }

    it 'creates question and assigns to a variable' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: {id: question.id} }

    it 'finds question by id and assigns to a variable' do
      expect(assigns(:question)).to eq(question)
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end
end

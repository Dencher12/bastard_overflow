require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
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
    let(:question) { FactoryBot.create(:question) }

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
end

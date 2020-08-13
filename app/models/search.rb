class Search < ApplicationRecord
  def self.search(query, search_type)
    case search_type
    when 'questions'
      Question.search conditions: {title: query}
    when 'answers'  
      Answer.search conditions: {body: query}
    when 'comments'
      Comment.search conditions: {text: query}
    when 'users'
      User.search conditions: {email: query}
    when 'everything'
      ThinkingSphinx.search query   
    end  
  end    
end

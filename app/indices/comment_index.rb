ThinkingSphinx::Index.define :comment, with: :active_record do
    indexes text
    
    has created_at, updated_at
  end   
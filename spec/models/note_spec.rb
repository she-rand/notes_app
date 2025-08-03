require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'validations' do
    it 'requires a title' do
      note = Note.new(content: 'Some content')
      expect(note).not_to be_valid
      expect(note.errors[:title]).to include("can't be blank")
    end
    
    it 'requires content' do
      note = Note.new(title: 'Some title')
      expect(note).not_to be_valid
      expect(note.errors[:content]).to include("can't be blank")
    end
    
    it 'is valid with title and content' do
      note = Note.new(title: 'Valid title', content: 'Valid content')
      expect(note).to be_valid
    end
  end
  
  describe '#preview' do
  it 'returns truncated content without markdown' do
    note = Note.new(title: 'Test', content: '# Big title with **bold** text')
    preview = note.preview(20)
    
    expect(preview).to include('Big title')
    expect(preview).not_to include('#')
    expect(preview).not_to include('**')
    expect(preview.length).to be <= 23  # 20 + "..." = 23
  end
end
end
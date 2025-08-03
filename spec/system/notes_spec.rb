require 'rails_helper'

RSpec.describe "Notes", type: :system do
  before do
    driven_by(:rack_test)
  end
  
  scenario "User creates a new note" do
    visit root_path
    click_link "New Note"
    
    fill_in "Title", with: "My Test Note"
    fill_in "Content", with: "# Hello\n\nThis is **bold** text."
    
    click_button "Create Note"
    
    expect(page).to have_content("Note was successfully created")
    expect(page).to have_content("My Test Note")
  end
  
  scenario "User views and edits a note" do
    note = Note.create!(title: "Existing Note", content: "Original content")
    
    visit note_path(note)
    expect(page).to have_content("Existing Note")
    
    click_link "Edit"
    fill_in "Title", with: "Updated Note"
    click_button "Update Note"
    
    expect(page).to have_content("Note was successfully updated")
    expect(page).to have_content("Updated Note")
  end
  
  scenario "User searches notes" do
  Note.create!(title: "Ruby Tutorial", content: "Learn Ruby")
  Note.create!(title: "Rails Guide", content: "Learn Rails")
  
  visit root_path
  
  # Usar placeholder en lugar de label
  fill_in placeholder: "Search notes...", with: "Ruby"
  click_button "Search"
  
  expect(page).to have_content("Ruby Tutorial")
  expect(page).not_to have_content("Rails Guide")
end
end
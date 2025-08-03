# 📝 Notes App

A modern Rails 7 application for creating and managing Markdown notes with live preview functionality.

## ✨ Features

### Core Functionality
- **📝 Full CRUD Operations** - Create, read, update, and delete notes
- **🔍 Real-time Search** - Search notes by title or content
- **⚡ Live Markdown Preview** - See formatted output as you type
- **📱 Responsive Design** - Works seamlessly on desktop and mobile
- **✅ Form Validation** - Client and server-side validation with helpful error messages

### Technical Highlights
- **🎯 Modern Rails 7** with Turbo and Stimulus
- **⚙️ JavaScript Modules** via Importmaps (no Node.js required)
- **🎨 Tailwind CSS** for beautiful, utility-first styling
- **🧪 Comprehensive Testing** with RSpec and Capybara
- **📊 Clean Architecture** following Rails MVC patterns

## 🚀 Getting Started

### Prerequisites
- Ruby 3.0+ 
- Rails 7.0+
- SQLite3 (default) or PostgreSQL
- Git

### Installation

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd notes_app
   ```

2. **Install dependencies:**
   ```bash
   bundle install
   ```

3. **Setup database:**
   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Start the development server:**
   ```bash
   rails server
   ```

5. **Visit the application:**
   ```
   http://localhost:3000
   ```

## 🎯 Usage

### Creating Notes
1. Click **"New Note"** button
2. Enter a descriptive title
3. Write content in **Markdown format** in the left panel
4. Watch the **live preview** update in the right panel
5. Click **"Create Note"** to save

### Markdown Support
The app supports full GitHub Flavored Markdown:

```markdown
# Headers
## Subheaders

**Bold text** and *italic text*

- Bulleted lists
- With multiple items

1. Numbered lists
2. Sequential items

`inline code` and:

```ruby
# Code blocks with syntax highlighting
def hello_world
  puts "Hello, World!"
end
```

> Blockquotes for important information

[Links](https://example.com) and more!
```

### Searching Notes
- Use the search bar on the main page
- Search works across both titles and content
- Results update instantly as you type

### Managing Notes
- **View:** Click any note title to see the formatted version
- **Edit:** Click the "Edit" button to modify with live preview
- **Delete:** Click "Delete" with confirmation prompt

## 🏗️ Technical Architecture

### Backend Stack
- **Framework:** Ruby on Rails 7.0+
- **Database:** SQLite3 (development), PostgreSQL ready
- **Testing:** RSpec, FactoryBot, Capybara
- **Search:** ActiveRecord with LIKE queries

### Frontend Stack
- **CSS Framework:** Tailwind CSS
- **JavaScript:** Stimulus controllers with Importmaps  
- **Markdown Processing:** marked.js library
- **No Build Step:** Pure Rails asset pipeline

### Key Components

#### Models
```ruby
# app/models/note.rb
class Note < ApplicationRecord
  validates :title, presence: true, length: { maximum: 200 }
  validates :content, presence: true
  
  scope :search, ->(query) { 
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%") 
  }
  
  def preview(length = 150)
    content.gsub(/[#*`_\[\]()]/, '').strip.truncate(length)
  end
end
```

#### Stimulus Controller
```javascript
// app/javascript/controllers/markdown_preview_controller.js
import { Controller } from "@hotwired/stimulus"
import { marked } from "marked"

export default class extends Controller {
  static targets = ["input", "preview"]
  
  connect() {
    this.updatePreview();
  }
  
  updatePreview() {
    const markdown = this.inputTarget.value;
    const html = marked.parse(markdown);
    this.previewTarget.innerHTML = html;
  }
}
```

## 🧪 Testing

### Running Tests
```bash
# Run all tests
bundle exec rspec

# Run specific test files
bundle exec rspec spec/models/note_spec.rb
bundle exec rspec spec/system/notes_spec.rb
```

### Test Coverage
- **Model Tests:** Validations, search functionality, preview method
- **System Tests:** End-to-end user workflows with Capybara
- **Integration Tests:** Complete user journeys from creation to deletion

### Test Example
```ruby
# spec/system/notes_spec.rb
scenario "User creates a new note" do
  visit root_path
  click_link "New Note"
  
  fill_in "Title", with: "My Test Note"
  fill_in "Content", with: "# Hello\n\nThis is **bold** text."
  
  click_button "Create Note"
  
  expect(page).to have_content("Note was successfully created")
  expect(page).to have_content("My Test Note")
end
```

## 📁 Project Structure

```
notes_app/
├── app/
│   ├── controllers/
│   │   └── notes_controller.rb      # CRUD operations
│   ├── models/
│   │   └── note.rb                  # Data model with validations
│   ├── views/
│   │   ├── layouts/
│   │   │   └── application.html.erb # Main layout
│   │   └── notes/
│   │       ├── index.html.erb       # Notes listing with search
│   │       ├── show.html.erb        # Individual note display
│   │       ├── new.html.erb         # Note creation form
│   │       ├── edit.html.erb        # Note editing form
│   │       └── _form.html.erb       # Shared form partial
│   └── javascript/
│       └── controllers/
│           └── markdown_preview_controller.js
├── config/
│   ├── routes.rb                    # URL routing
│   └── importmap.rb                 # JavaScript module configuration
├── db/
│   └── migrate/                     # Database migrations
├── spec/                            # Test suite
│   ├── models/
│   ├── system/
│   └── factories/
└── README.md
```

## 🚀 Deployment

### Heroku Deployment
1. **Add Heroku buildpacks:**
   ```bash
   heroku buildpacks:add heroku/ruby
   ```

2. **Configure for production:**
   ```ruby
   # config/database.yml - production section
   production:
     adapter: postgresql
     url: <%= ENV['DATABASE_URL'] %>
   ```

3. **Deploy:**
   ```bash
   git push heroku main
   heroku run rails db:migrate
   ```

### Railway/Render Deployment
- Both platforms support Rails 7 out of the box
- Ensure `Procfile` contains: `web: bundle exec rails server -p $PORT`
- Set `RAILS_ENV=production` environment variable

## 🔧 Development

### Adding New Features
1. **Create feature branch:**
   ```bash
   git checkout -b feature/new-feature
   ```

2. **Write tests first (TDD):**
   ```bash
   # Add tests to appropriate spec files
   bundle exec rspec
   ```

3. **Implement feature**
4. **Ensure tests pass**
5. **Create pull request**

### Code Style
- Follow Rails conventions
- Use descriptive variable and method names
- Keep controllers thin, models fat
- Write meaningful commit messages
- Add comments for complex business logic

## 🐛 Troubleshooting

### Common Issues

**JavaScript not loading:**
```bash
# Restart Rails server
rails server

# Check importmap configuration
./bin/importmap json
```

**Search not working:**
- Ensure database supports LIKE queries
- Check Note model search scope
- Verify search form parameters

**Tests failing:**
```bash
# Reset test database
rails db:test:prepare

# Run specific failing test with output
bundle exec rspec spec/path/to/failing_spec.rb --format documentation
```

## 📚 Learning Resources

### Rails 7 Features Used
- **Importmaps:** [Rails Importmaps Guide](https://github.com/rails/importmap-rails)
- **Stimulus:** [Stimulus Handbook](https://stimulus.hotwired.dev/)
- **Turbo:** [Turbo Reference](https://turbo.hotwired.dev/)

### Additional Resources
- [Rails Guides](https://guides.rubyonrails.org/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [RSpec Documentation](https://rspec.info/)
- [Markdown Guide](https://www.markdownguide.org/)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👨‍💻 Author

Built with ❤️ as a learning project to demonstrate modern Rails 7 development practices.

---

**Happy note-taking! 📝✨**
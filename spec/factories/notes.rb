FactoryBot.define do
  factory :note do
    title { "Sample Note" }
    content { "# Hello World\n\nThis is a **test** note." }
  end
end
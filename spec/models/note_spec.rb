require 'rails_helper'

RSpec.describe Note, type: :model do
  # 検索文字列に一致するメモを返すこと
  it "returns notes that match the search term" do
    user = User.create(
      first_name: "John",
      last_name: "Doe",
      email: "john.doe@example.com",
      password: "password"
    )
    project = user.projects.create(
      name: "Project 1",
      description: "This is the first project"
    )
    note1 = project.notes.create(
      message: "This is the first note",
      user_id: user.id
    )

    note2 = project.notes.create(
      message: "This is the second note",
      user_id: user.id
    )

    note3 = project.notes.create(
      message: "This is the first note",
      user_id: user.id
    )

    expect(Note.search("first")).to include(note1, note3)
    expect(Note.search("second")).to include(note2)
    expect(Note.search("third")).not_to include(note1, note2, note3)
  end

  # 検索結果が1件も⾒つからなければ空のコレクションを返すこと
  it "returns an empty collection when no results are found" do
    user = User.create(
      first_name: "John",
      last_name: "Doe",
      email: "john.doe@example.com",
      password: "password"
    )
    project = user.projects.create(
      name: "Project 1",
      description: "This is the first project"
    )
    note = project.notes.create(
      message: "This is the first note",
      user_id: user.id
    )
    expect(Note.search("nonexistent")).to be_empty
  end
end

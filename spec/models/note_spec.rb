require 'rails_helper'

RSpec.describe Note, type: :model do

  before do
    @user = User.create(
      first_name: "John",
      last_name: "Doe",
      email: "john.doe@example.com",
      password: "password"
    )
    @project = @user.projects.create(
      name: "Project 1",
      description: "This is the first project"
    )
  end

  # ユーザー、プロジェクト、メッセージがあれば有効な状態であること
  it "is valid with a user, project, and message" do
    note = Note.new(
      user_id: @user.id,
      project_id: @project.id,
      message: "This is the first note"
    )
    expect(note).to be_valid
  end

  # メッセージがなければ無効な状態であること
  it "is invalid without a message" do
    note = Note.new(
      user_id: @user.id,
      project_id: @project.id,
      message: nil
    )
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end

  # ⽂字列に⼀致するメッセージを検索する
  describe "search message for a term" do
    before do
      @note1 = @project.notes.create(
        message: "This is the first note",
        user_id: @user.id
      )

      @note2 = @project.notes.create(
        message: "This is the second note",
        user_id: @user.id
      )

      @note3 = @project.notes.create(
        message: "This is the first note",
        user_id: @user.id
      )
    end

    # ⼀致するデータが⾒つかるとき
    context "when a match is found" do
      # 検索⽂字列に⼀致するメモを返すこと
      it "returns notes that match the search term" do
        expect(Note.search("first")).to include(@note1, @note3)
      end
    end

    # ⼀致するデータが⾒つからないとき
    context "when no match is found" do
      # 空のコレクションを返すこと
      it "returns an empty collection" do
        expect(Note.search("nonexistent")).to be_empty
      end
    end
  end
  # it "returns notes that match the search term" do
  #   user = User.create(
  #     first_name: "John",
  #     last_name: "Doe",
  #     email: "john.doe@example.com",
  #     password: "password"
  #   )
  #   project = user.projects.create(
  #     name: "Project 1",
  #     description: "This is the first project"
  #   )
  #   note1 = project.notes.create(
  #     message: "This is the first note",
  #     user_id: user.id
  #   )

  #   note2 = project.notes.create(
  #     message: "This is the second note",
  #     user_id: user.id
  #   )

  #   note3 = project.notes.create(
  #     message: "This is the first note",
  #     user_id: user.id
  #   )

  #   expect(Note.search("first")).to include(note1, note3)
  #   expect(Note.search("second")).to include(note2)
  #   expect(Note.search("third")).not_to include(note1, note2, note3)
  # end

  # # 検索結果が1件も⾒つからなければ空のコレクションを返すこと
  # it "returns an empty collection when no results are found" do
  #   user = User.create(
  #     first_name: "John",
  #     last_name: "Doe",
  #     email: "john.doe@example.com",
  #     password: "password"
  #   )
  #   project = user.projects.create(
  #     name: "Project 1",
  #     description: "This is the first project"
  #   )
  #   note = project.notes.create(
  #     message: "This is the first note",
  #     user_id: user.id
  #   )
  #   expect(Note.search("nonexistent")).to be_empty
  # end
end

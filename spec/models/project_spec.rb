require 'rails_helper'

RSpec.describe Project, type: :model do
  # ユーザー単位では重複したプロジェクト名を許可しないこと
  it "does not allow duplicate project names per user" do
    user = User.create(
      first_name: "John",
      last_name: "Doe",
      email: "john.doe@example.com",
      password: "password"
    )
    user.projects.create(
      name: "Project 1",
      description: "This is the first project"
    )

    new_project = user.projects.build(
      name: "Project 1",
      description: "This is the second project"
    )
    
    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
    
  end

  # 二人のユーザーが同じ名前を使うことは許可する
  it "allows two users to share a project name" do
    user1 = User.create(
      first_name: "John",
      last_name: "Doe",
      email: "john.doe@example.com",
      password: "password"
    )

    user1.projects.create(
      name: "Project 1",
      description: "This is the first project"
    )

    user2 = User.create(
      first_name: "Jane",
      last_name: "Smith",
      email: "jane.smith@example.com",
      password: "password"
    )

    other_project = user2.projects.build(
      name: "Project 1",
      description: "This is another project with the same name"
    )
    expect(other_project).to be_valid
  end
end

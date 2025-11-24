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
end

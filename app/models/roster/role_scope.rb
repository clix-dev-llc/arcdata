class Roster::RoleScope < ApplicationRecord
  belongs_to :role_membership

  def scope
    val = super
    if val =~ /\A\d+\z/
      val.to_i
    else
      val
    end
  end
end

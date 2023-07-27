class JwtDenylist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist
  # the denyList is used to store the JWT tokens that have been revoked
  self.table_name = 'jwt_denylist'
end

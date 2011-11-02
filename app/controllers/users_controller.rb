class UsersController < ApplicationController
  authorize_resource # CanCan
  active_scaffold :user do |conf|
  end
end 
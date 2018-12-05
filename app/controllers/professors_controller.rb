class ProfessorsController < ApplicationController
  def index
    @professors = Professor.order(created_at: :desc)
  end
end

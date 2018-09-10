class Admins::AcademicsController < Admins::BaseController
    
    def index
        @academics = Academic.all
    end
end    
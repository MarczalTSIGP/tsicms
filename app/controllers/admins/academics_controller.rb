class Admins::AcademicsController < Admins::BaseController
    
    before_action :set_academic, only: [:edit, :update, :destroy]

    def index
        @academics = Academic.all.order(created_at: :ASC)
    end

    def show
        set_academic
    end

    def new 
        @academic = Academic.new
    end    

    def create
        @academic = Academic.new(academic_params)
        if @academic.save
            flash[:success]="Acadêmico: #{@academic.name} criado com sucesso."
            redirect_to action: 'index'
        else 
            flash[:error]="Existem dados incorretos!"
            render :new  
        end  
    end

    def edit
        set_academic
    end   
    
    def update
        if set_academic.update_attributes(academic_params)
            flash[:success] = "Acadêmico: #{@academic.name} atualizado com sucesso."
            redirect_to action: 'index'
            
        else 
            flash[:error]="Existem dados incorretos."
            render :edit  
            
        end      
    end

    def destroy
        @academic.destroy
        flash[:success]="Acadêmico: #{@academic.name} deletado com sucesso."
        redirect_back fallback_location: @get
    end

    protected
    def academic_params
        params.require(:academic).permit(:name, :image, :contact, :graduated)
    end    

    def set_academic
        @academic = Academic.find(params[:id])
    end    

end   
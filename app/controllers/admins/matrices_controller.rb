class Admins::MatricesController < Admins::BaseController
  
    before_action :set_matrices, only: [ :edit, :update, :destroy, :show]
  
    def index
      @matrices = Matrix.all.paginate(:page => params[:page], :per_page => 8).order(name: :asc)
    end
  
    def new
      @matrix = Matrix.new
    end
  
    def edit
      @matrix = Matrix.find(params[:id])
    end
  
    def create
      @matrix = Matrix.new(matrix_params)
  
      if @matrix.save
        flash[:success] = I18n.t('flash.actions.create.f', resource_name: Matrix.model_name.human)
        redirect_to admins_matrices_path
      else
        flash.now[:error] = I18n.t('flash.actions.errors')
        render :new
      end
    end
  
  
    def update
      @matrix = Matrix.find(params[:id])
  
      if @matrix.update_attributes(matrix_params)
        flash[:success] = I18n.t('flash.actions.update.f', resource_name: Matrix.model_name.human)
        redirect_to admins_matrices_path            
      else
        flash.now[:error] = I18n.t('flash.actions.errors')
        render :edit
      end
  
    end
  
    def destroy
      @matrix = Matrix.find(params[:id])
      
      @matrix.destroy
      flash[:success] = I18n.t('flash.actions.destroy.f', resource_name: Matrix.model_name.human) 
      redirect_to admins_matrices_path
    end
  
    private 
  
      def matrix_params
        params.require(:matrix).permit(:name)
      end
  
      def set_matrices
        @matrix = Matrix.find(params[:id])
      end
     
    
  end
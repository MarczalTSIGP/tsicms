class Admins::DisciplinesController < Admins::BaseController

    before_action :set_discipline, only: [ :edit, :update, :destroy, :show]
    
    def index
      @disciplines = Discipline.all.paginate(:page => params[:page], :per_page =>8).order(name: :asc)
    end
  
    def new
      @discipline = Discipline.new
    end
  
    def edit
    end
  
    def show
    end
  
    def create
      @discipline = Discipline.new(discipline_params)
  
      if @discipline.save
        flash[:success] = I18n.t('flash.actions.create.f', resource_name: Discipline.model_name.human)
        redirect_to admins_disciplines_path
      else
        flash.now[:error] = I18n.t('flash.actions.errors')
        render :new
      end
    end
  
    def update
      @discipline = Discipline.find(params[:id])
  
      if @discipline.update_attributes(discipline_params)
        redirect_to admins_disciplines_path
        flash[:success] = I18n.t('flash.actions.update.f', resource_name: Discipline.model_name.human)
      else
        flash.now[:error] = I18n.t('flash.actions.errors')
        render :edit
      end
  
    end
  
    def destroy
      @discipline = Discipline.find(params[:id])
      @discipline.destroy
      flash[:success] = I18n.t('flash.actions.destroy.f', resource_name: Discipline.model_name.human)
      redirect_to admins_disciplines_path
    end
  
    private 
  
      def discipline_params
        params.require(:discipline).permit(:name, :code, :hours, :menu, :period_id)
      end
  
      def set_discipline
        @discipline = Discipline.find(params[:id])
      end
  
  end
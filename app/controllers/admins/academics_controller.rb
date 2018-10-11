class Admins::AcademicsController < Admins::BaseController
    before_action :set_academic, only: [:edit, :update, :destroy]

    def index
        @academics = Academic.order(created_at: :desc)
    end

    def new
        @academic = Academic.new
    end

    def create
        @academic = Academic.new(academic_params)
        if @academic.save
            flash[:success] = I18n.t('flash.actions.create.m',
                                     resource_name: Academic.model_name.human)
            redirect_to admins_academics_path
        else
            flash.now[:error] = I18n.t('flash.actions.errors')
            render :new
        end
    end

    def edit
        set_academic
    end

    def update
        if set_academic.update(academic_params)
            flash[:success] = I18n.t('flash.actions.update.m',
                                     resource_name: Academic.model_name.human)
            redirect_to admins_academics_path
        else
            flash.now[:error] = I18n.t('flash.actions.errors')
            render :edit
        end
    end

    def destroy
        @academic.destroy
        flash[:success] = I18n.t('flash.actions.destroy.m',
                                 resource_name: Academic.model_name.human)
        redirect_to admins_academics_path
    end

    protected

    def academic_params
        params.require(:academic).permit(:name,
                                         :image,
                                         :image_cache,
                                         :contact,
                                         :graduated)
    end

    def set_academic
        @academic = Academic.find(params[:id])
    end

end

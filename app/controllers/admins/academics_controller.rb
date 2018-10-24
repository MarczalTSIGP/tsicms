class Admins::AcademicsController < Admins::BaseController
    add_breadcrumb "Acadêmicos", :admins_academics_path

    before_action :set_academic, only: [:edit, :update, :destroy]

    def index
        @academics = Academic.order(created_at: :desc)
    end

    def new
        add_breadcrumb "Novo Acadêmico", :new_admins_academic_path
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
        add_breadcrumb "Editar Acadêmico: #{@academic.name} ", :edit_admins_academic_path
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
                                         :contact,
                                         :image_cache,
                                         :graduated)
    end

    def set_academic
        @academic = Academic.find(params[:id])
    end

end

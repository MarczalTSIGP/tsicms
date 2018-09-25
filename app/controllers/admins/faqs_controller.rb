class Admins::FaqsController < Admins::BaseController

  def index
    @faqs = Faq.order(created_at: :asc)
  end

  def new
    @faq = Faq.new
  end

  def create
    @faq = Faq.new(faq_params)

    if @faq.save
      flash[:success] = "Pergunta salva com sucesso!"
      redirect_to admins_faqs_path
    else
      flash[:error] = "Erro! Existem dados incorretos!"
      render :new
    end
  end

  def edit
    @faq = Faq.find(params[:id])
  end

  def update
    @faq = Faq.find(params[:id])

    if @faq.update_attributes(faq_params)
      flash[:success] = "Pergunta atualizada com sucesso!"
      redirect_to admins_faqs_path
    else
      flash[:error] = "Erro! Existem dados incorretos!"
      render :edit
    end
  end

  def destroy
    @faq = Faq.find(params[:id])

    @faq.destroy
    flash[:success] = "Pergunta removida com sucesso!"
    redirect_to admins_faqs_path
  end

  protected
  def faq_params
    params.require(:faq).permit(:title, :answer)
  end

end
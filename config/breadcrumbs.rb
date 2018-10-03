crumb :root do
  link "Admins", admins_root_path
end

###############
crumb :matrices do
  link "Matrizes", admins_matrices_path
end

crumb :edit_matrix do |p|
  link "Editar Matriz", p
  parent :matrices, p
end

crumb :new_matrix do |p|
  link "Nova Matriz", p
  parent :matrices, p
end

crumb :show_matrix do |p|
  link " Visualizar", p
  parent :matrices, p
end

###############
crumb :periods do
  link "Periodos", admins_periods_path
end

crumb :edit_period do |c|
  link "Editar Periodo", c
  parent :periods, c
end

crumb :new_period do |c|
  link "Novo Periodo", c
  parent :periods, c
end

crumb :show_period do |c|
  link "Visualizar", c
  parent :periods, c
end
###############

crumb :disciplines do
  link "Disciplinas", admins_disciplines_path
end

crumb :edit_discipline do |pk|
  link "Editar Disciplina", pk
  parent :disciplines, pk
end

crumb :new_discipline do |pk|
  link "Nova Disciplina", pk
  parent :disciplines, pk
end

crumb :show_discipline do |pk|
  link " Visualizar", pk
  parent :disciplines, pk
end

###############

crumb :teachers do
  link "Professores", admins_professors_path
end

crumb :edit_teacher do |pk|
  link "Editar Professor", pk
  parent :teachers, pk
end

crumb :new_teacher do |pk|
  link "Novo Professor", pk
  parent :teachers, pk
end

crumb :show_teacher do |pk|
  link "Visualizar Professor", pk
  parent :teachers, pk
end

###############

crumb :academics do
  link "Academicos", admins_academics_path
end

crumb :edit_academic do |pk|
  link "Editar Academico", pk
  parent :academics, pk
end

crumb :new_academic do |pk|
  link "Novo Academico", pk
  parent :academics, pk
end

crumb :show_academic do |pk|
  link " #{pk.name}", pk
  parent :academics, pk
end

###############

crumb :companies do
  link "Empresas", admins_companies_path
end

crumb :edit_company do |pk|
  link "Editar Empresa", pk
  parent :companies, pk
end

crumb :new_company do |pk|
  link "Nova Empresa", pk
  parent :companies, pk
end

crumb :show_company do |pk|
  link " #{pk.name}", pk
  parent :companies, pk
end

###############

crumb :indications do
  link "Indicações", admins_indications_path
end

crumb :edit_indication do |pk|
  link "Editar Indicação", pk
  parent :indications, pk
end

crumb :new_indication do |pk|
  link "Nova Indicação", pk
  parent :indication, pk
end

crumb :show_indication do |pk|
  link " #{pk.name}", pk
  parent :indications, pk
end

###############

crumb :galleries do
  link "Galerias", admins_galleries_path
end

crumb :edit_gallery do |pk|
  link "Editar Galeria", pk
  parent :galleries, pk
end

crumb :new_gallery do |pk|
  link "Nova Galeria", pk
  parent :galleries, pk
end

crumb :show_gallery do |pk|
  link " #{pk.name}", pk
  parent :galleries, pk
end

###############

crumb :categories do
  link "Categorias de Recomendações", admins_category_recommendations_path
end

crumb :edit_categories do |cr|
  link "Editar Categoria", cr
  parent :categories, cr
end

crumb :new_categories do |cr|
  link "Nova Categoria", cr
  parent :categories, cr
end

crumb :show_categories do |cr|
  link "Visualizar Categoria", cr
  parent :categories, cr
end

###############

crumb :recomendations do
  link "Recomendações de Conteúdo", admins_recommendations_path
end

crumb :edit_recomendations do |cr|
  link "Editar Recomendação", cr
  parent :recomendations, cr
end

crumb :new_recomendations do |cr|
  link "Nova Recomendação", cr
  parent :recomendations, cr
end

crumb :show_recommendations do |cr|
  link "Visualizar Recomendação", cr
  parent :recomendations, cr
end

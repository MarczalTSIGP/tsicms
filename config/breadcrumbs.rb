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
  link " #{pk.name}", pk
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
# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
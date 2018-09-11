Admin.create_with(name: 'Administrador', password: '123456').find_or_create_by!(email: 'admin@admin.com')

ProfessorCategory.create(name: 'Efetivo')
ProfessorCategory.create(name: 'Temporario')

ProfessorTitle.create(description: 'Especialista', abbrev: 'Esp.')
ProfessorTitle.create(description: 'Mestre', abbrev: 'Me.')
ProfessorTitle.create(description: 'Doutor', abbrev: 'Dr.')


10.times do |n|
  @title = ProfessorTitle.first
  @category = ProfessorCategory.first
  Professor.create(name: "Name#{n}", lattes: "lates#{n}",
                   occupation_area: "area de ocupacao#{n}", email: "email#{n}@email.com",
                   professor_title: @title, professor_category: @category)
end

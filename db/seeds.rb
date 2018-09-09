Admin.create_with(name: 'Administrador', password: '123456').find_or_create_by!(email: 'admin@admin.com')

ProfessorCategory.create_with(name: 'Efetivo')
ProfessorCategory.create_with(name: 'Temporario')

ProfessorTitle.create_with(description: 'Especialista', abbrev: 'Esp.')
ProfessorTitle.create_with(description: 'Mestre', abbrev: 'Me.')
ProfessorTitle.create_with(description: 'Doutor', abbrev: 'Dr.')

100.times do |n|
  Professor.create(name: "Name#{n}", lattes: "lates#{n}",
                   occupation_area: "area de ocupacao#{n}", email: "email#{n}@email.com")
end
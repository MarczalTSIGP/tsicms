Admin.create_with(name: 'Administrador', password: '123456').find_or_create_by!(email: 'admin@admin.com')

100.times do |n|
  Professor.create(name: "Name#{n}", lattes: "lates#{n}",
                   occupation_area: "area de ocupacao#{n}", email: "email#{n}@email.com")
end
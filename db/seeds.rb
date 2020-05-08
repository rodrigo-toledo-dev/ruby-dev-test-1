directory_sp = FileSystem.create(name: 'Sao Paulo')
directory_sp.children.create(name: 'Casos confirmados')
directory_sp.children.create(name: 'Casos nao confirmados')

directory_rj = FileSystem.create(name: 'Rio de Janeiro')
final_directory = directory_rj.children.create(name: 'Casos confirmados')
final_directory.children.create(name: 'Em quarenta')
directory_rj.children.create(name: 'Casos nao confirmados')

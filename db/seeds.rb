directory_sp = FileSystem.create(name: 'sao-paulo')
directory_sp.children.create(name: 'casos-confirmados')
directory_sp.children.create(name: 'casos-nao-confirmados')

directory_rj = FileSystem.create(name: 'rio-de-janeiro')
directory_rj.children.create(name: 'casos-confirmados')
directory_rj.children.create(name: 'casos-nao-confirmados')

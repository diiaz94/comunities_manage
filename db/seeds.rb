# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Type.create(
				[
					{nombre: "Administrador",descripcion: "Administra la aplicacion"},
					{nombre: "Miembro",descripcion: "Miembro de algun consejo comunal"},
					{nombre: "SimpleUser",descripcion: "Usuario comun"}

				]
			)

Job.create(
				[
					{nombre: "Director",descripcion: "Dirigue el consejo comunal"}

				]
			)

StatusRequest.create([
						{nombre: "Pendiente"},
						{nombre: "Revisada"},
						{nombre: "Completada"},

					])

State.create([
				{nombre: "Distrito Capital"}
			])

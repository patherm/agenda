# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Li.create(set: 'Ambulatório')
Li.create(set: 'Acolhimento/Triagem')
Li.create(set: 'Assessoria de Comunicação (ASCOM)/Imprensa')

Tel.create(tel: '8721016511', ram: '6511', li_id: Li.find_by(set: 'Ambulatório').id)

Tel.create(tel: '8721016512', ram: '6512', li_id: Li.find_by(set: 'Acolhimento/Triagem').id)

Tel.create(tel: '8721016513', ram: '6513', li_id: Li.find_by(set: 'Assessoria de Comunicação (ASCOM)/Imprensa').id)
Tel.create(tel: '8721016514', ram: '6514', li_id: Li.find_by(set: 'Assessoria de Comunicação (ASCOM)/Imprensa').id)
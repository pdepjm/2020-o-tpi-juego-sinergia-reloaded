import wollok.game.*
import objetos.*
import agente.*
import villano.*

const icono_agente = new Objeto(image = "Objetos/icono_agente.png", position = game.at(11,15))
const icono_villano = new Objeto(image = "Objetos/icono_villano.png", position = game.at(1,15))


object pantalla {
	const property elementos = []
	
	method disenio(){
		elementos.add(new Objeto(image = "Objetos/label_poder.png", position = game.at(3,16)))
		elementos.add(new Objeto(image = "Objetos/label_poder.png", position = game.at(22,16)))
		elementos.add(new Objeto(image = "Objetos/label_time.png", position = game.at(6,16)))
		elementos.add(new Objeto(image = "Objetos/label_vidas.png", position = game.at(13,16)))
		elementos.add(new Objeto(image = "Objetos/label_inventario.png", position = game.at(17,16)))
		
		elementos.add(new Objeto(image = "Objetos/celda_negra.png", position = game.at(0,15)))
		elementos.add(new Objeto(image = "Objetos/celda_negra.png", position = game.at(0,16)))
		elementos.add(new Objeto(image = "Objetos/celda_negra.png", position = game.at(5,16)))
		elementos.add(new Objeto(image = "Objetos/celda_negra.png", position = game.at(10,16)))
		elementos.add(new Objeto(image = "Objetos/celda_negra.png", position = game.at(16,16)))
		elementos.add(new Objeto(image = "Objetos/celda_negra.png", position = game.at(21,16)))
		elementos.add(new Objeto(image = "Objetos/celda_negra.png", position = game.at(24,15)))
		elementos.add(new Objeto(image = "Objetos/celda_negra.png", position = game.at(24,16)))
		elementos.add(new Objeto(image = "Objetos/celdax8_negra.png", position = game.at(3,15)))
		elementos.add(new Objeto(image = "Objetos/celdax11_negra.png", position = game.at(13,15)))
		elementos.add(new Objeto(image = "Objetos/celda2x2_negra.png", position = game.at(11,15)))
		
	}
	
	method aparecer(){
		self.disenio()
		elementos.forEach({objeto => objeto.aparecer()})
	}	
}


object my_clock{
	const init_clock = new Set()
	const dos_puntos = new Objeto(image = "Objetos/dos_puntos.png", position = game.at(7,15))
	const posc1 = new Reloj(limite_indice = 9, indice = 0,segundos = 60000,  clock_posc = new Objeto(image = "Objetos/uno.png", position = game.at(6,15)))
	const posc3 = new Reloj(limite_indice = 5, indice = 4,segundos = 10000,  clock_posc = new Objeto(image = "Objetos/cinco.png", position = game.at(8,15)))
	const posc4 = new Reloj(limite_indice = 9, indice = 9, segundos = 1000,  clock_posc = new Objeto(image = "Objetos/nueve.png", position = game.at(9,15)))
	
	method crear_reloj(){
		init_clock.add(posc1)
		init_clock.add(posc3)
		init_clock.add(posc4)
	}
	
	method iniciar(){
		dos_puntos.aparecer()
		self.crear_reloj()	
		init_clock.forEach({objeto => objeto.accionar()})
	}
	
	method detener(){
		
		init_clock.forEach({objeto => objeto.stop_time()})
	}
}


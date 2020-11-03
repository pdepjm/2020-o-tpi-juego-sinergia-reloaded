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
	const property init_clock = new Set()
	var property seg = 120
	const segundos = new Objeto(image = "Objetos/s.png", position = game.at(9,15))
	const property posc1 = new Reloj( indice = seg.div(100), clock_posc = new Objeto(image = "Objetos/cero.png", position = game.at(6,15)))
	const property posc2 = new Reloj( indice = (seg - (posc1.indice()*100)) / 10, clock_posc = new Objeto(image = "Objetos/cero.png", position = game.at(7,15)))
	const property posc3 = new Reloj( indice = seg - (posc1.indice()*100) -(posc2.indice()*10), clock_posc = new Objeto(image = "Objetos/cero.png", position = game.at(8,15)))
	
	method crear_reloj(){
		init_clock.add(posc1)
		init_clock.add(posc2)
		init_clock.add(posc3)
	}
	
	method iniciar(){
		segundos.aparecer()
		self.crear_reloj()
		init_clock.forEach({objeto => objeto.aparecer()})
		game.onTick(1000, "reloj", { self.accionar() })		
	}
	
	method accionar(){
		if (seg >= 0){
			init_clock.forEach({objeto => objeto.accionar()})
			seg --
			self.set_indice()
		}
		else {
			game.removeTickEvent("reloj")
			game.say(villano, "GAME OVER villano: fin del tiempo")
			game.schedule(4000, { game.stop() })
			game.schedule(1000, {game.sound("Musica/game_over.mp3").play()})
		}	
	}
	
	method set_indice(){
		posc1.indice(seg.div(100)) 
		posc2.indice((seg - (posc1.indice()*100)).div(10))
		posc3.indice(seg - (posc1.indice()*100) - (posc2.indice()*10))
	}
}

object pantallaIntro {
	var inicio = true
	const portada = new Objeto (image = "Objetos/portada.png", position = game.at(0,0))
	const instrucciones = new Objeto (image = "Objetos/instrucciones.png", position = game.at(0,0))
	
	method ejecutar() {
		portada.aparecer()
		game.schedule(7000, { portada.desaparecer()
							instrucciones.aparecer() })		
	}
	
	method iniciar(){
		if (inicio){
			instrucciones.desaparecer()
			my_clock.iniciar()
			inicio = false
		}
	}
}


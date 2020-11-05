import wollok.game.*
import objetos.*
import agente.*
import villano.*
import configuracion.*
import teclas.*

const musica = game.sound("Musica/miusik.mp3")

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
			game.schedule(1000, {gameOver.control(true) gameOver.accionar(villano) })
			game.schedule(1000, {game.sound("Musica/game_over.mp3").play()})
		}	
	}
	
	method set_indice(){
		posc1.indice(seg.div(100)) 
		posc2.indice((seg - (posc1.indice()*100)).div(10))
		posc3.indice(seg - (posc1.indice()*100) - (posc2.indice()*10))
	}
	
	method setear(){
		seg = 10
		init_clock.clear()
	}
}



object pantallaIntro {
	var control = true
	const portada = new Objeto (image = "Objetos/portada.png", position = game.at(0,0))
	const instruccion = new Objeto (image = "Objetos/instrucciones.png", position = game.at(0,0))
	
	method ejecutar() {
		portada.aparecer()
		game.schedule(5000, { 	portada.desaparecer()
								instruccion.aparecer() 						
								comandos_game.control(true)})		
	}
	
	method accionar(){
		if (control){
			instruccion.desaparecer()
			musica.pause()
			my_clock.iniciar()
			control = false
		}
	}
}



object comandos_game{
	var property control = true
	const comandos = new Objeto (image = "Objetos/comandos.png", position = game.at(0,0))
	const i = new Objeto (image = "Objetos/i.png", position = game.at(6,1))
	const i2 = new Objeto (image = "Objetos/i2.png", position = game.at(6,1))
	
	method accionar(){
		if (control){
			comandos.aparecer()
			i.aparecer()
			control = false
		}
		else {
			control = true	
			i2.aparecer() 	
			i.desaparecer()
			game.schedule(500, { i2.desaparecer() comandos.desaparecer() })			
			
		}
	}
}




object gameOver{
	var property control = true
	const mygame = new Objeto (image = "Objetos/gameOverFondo.png", position = game.at(0,0))
	const over = new Objeto (image = "Objetos/gameover.png", position = game.at(7,8))
	const winner = new Objeto (image = "Objetos/winner.png", position = game.at(8,7))
	const o = new Objeto (image = "Objetos/o.png", position = game.at(7,3))
	const icono_agente = new Objeto(image = "Objetos/icono_agente.png", position = game.at(11,11))
	const icono_villano = new Objeto(image = "Objetos/icono_villano.png", position = game.at(11,11))
	
	method accionar(personaje){
		teclas.inhabilitar_teclas()
		musica.resume()
		mygame.aparecer()
		
		if (control){
			over.aparecer()
		}
		else{
			winner.aparecer()
			if (personaje.name() == "agente")
				icono_agente.aparecer()
			else
				icono_villano.aparecer()
		}
		o.aparecer()
		exit_game.control(true)
	}
	
}
		


object exit_game{
	var posicion = game.at(7,3)
	var property control = false
	var property o2 = new Objeto (image = "Objetos/o2.png", position = posicion)
	
	method accionar(){
		if (control){
			game.getObjectsIn(posicion).clear() /*tecla o */
			o2.aparecer()
			game.schedule(1000, { game.stop() })
		}
	}
	
	method posicion(nuevaPosicion) { posicion = nuevaPosicion}
}




	



import jugadores.*
import wollok.game.*

class Objeto {
	var property image
	var property position

	method aparecer() {
		const x = 2.randomUpTo(26).truncate(0)
		const y = 0.randomUpTo(14).truncate(0)
		position = game.at (x, y)
		game.addVisual(self)
	}
	
	method atrapado(destinoImagen){
		self.desaparecer()
	}
	
	method desaparecer() {
		game.removeVisual(self)
		
	}
	
	method usar(jugador) {	}	
}

class LiquidoAzul inherits Objeto {
	override method atrapado(direccion){
		super(direccion)
		game.addVisualIn("objeto_azul.png", direccion)
	}
	
	override method usar(jugador){
		jugador.contrincante().quedarseQuieto(10000)
	}
}

class LiquidoVerde inherits Objeto {
	override method atrapado(direccion){
		super(direccion)
		game.addVisualIn("objeto_amarillo.png", direccion)
	}
}

class LiquidoRojo inherits Objeto {
	override method usar(jugador){
		if(jugador.esAgente()){
			jugador.recuperarVida()
		}
	}
	override method atrapado(direccion){
		super(direccion)
		game.addVisualIn("objeto_rojo.png", direccion)
	}
	
}

class Bomba {
	
}

const objetoAzul = new LiquidoAzul(image="objeto_azul.png", position = game.at(14,5))

const objetoVerde = new LiquidoVerde(image="objeto_amarillo.png", position = game.at(4,10))

const objetoRojo = new LiquidoRojo(image="objeto_rojo.png", position = game.at(10,9))


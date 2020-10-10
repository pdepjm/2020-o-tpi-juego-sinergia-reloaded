import jugadores.*
import wollok.game.*
import mapas.mapa.*
import utilities.aleatorio.*
import villano.*
import agente.*

class Objeto {
	var property image 
	var property position
	
	method aparecer(){
		game.addVisual(self)
	}
	
	method desaparecer() {
		game.removeVisual(self)
	}
	
}

class ObjetoAleatorio inherits Objeto{
	override method aparecer() {
		position = aleatorio.nuevaPosicion()
		super()
	}
}

class ObjetoColeccionable inherits ObjetoAleatorio{
	
	var property posicionDestino

    method atrapado(){
		self.desaparecer()
		position = posicionDestino
		game.addVisual(self)
	}
	
	method interactuar(){ 
		self.atrapado()
		agente.guardarColeccionable(self)
	}
	
	method reaparecer() {
		self.desaparecer()
		self.aparecer()
	}
}

class Poder inherits ObjetoAleatorio{
	
	method crearReplica(direccion){return new Objeto()}
	
	method atrapado(){
		self.desaparecer()
		self.aparecer()
	}
	
	method usar(jugador) {
		self.desaparecer()
	}	
}

class LiquidoAzul inherits Poder {
	
	override method crearReplica(direccion){
		return new LiquidoAzul(image="Objetos/objeto_azul.png", position = direccion)
	}
	
	override method usar(jugador){
		jugador.contrincante().quedarseQuieto(3000)
		super(jugador)
	}
}

class LiquidoVerde inherits Poder {

	override method crearReplica(direccion){
		return new LiquidoVerde(image="Objetos/objeto_amarillo.png", position = direccion)
	}
	
	override method usar(jugador){
		jugador.usarObjetoVerde()
		super(jugador)
	}
}

class LiquidoRojo inherits Poder {
	override method crearReplica(direccion){
		return new LiquidoRojo(image="Objetos/objeto_rojo.png", position = direccion)
	}
	
	override method usar(jugador){
		jugador.usarObjetoRojo()
		super(jugador)
	}
}

class Pinches inherits Objeto {
	method interactuar(){
		agente.perderVida()
		self.desaparecer()
	}
}

class Pared inherits Objeto {
	
}

class Martillo inherits Objeto {
	method construir(persona){
		const pared = new Pared(image = "muro.png", position = persona.posicionAModificar())
		game.addVisual(pared) 
	}
	

}


const vida1 = new Objeto(image = "Objetos/vida.png", position = game.at(0,13))

const vida2 = new Objeto(image = "Objetos/vida.png", position = game.at(0,12))

const vida3 = new Objeto(image = "Objetos/vida.png", position = game.at(0,11))

const objetoAzul = new LiquidoAzul(image="Objetos/objeto_azul.png", position = game.at(14,5))

const objetoVerde = new LiquidoVerde(image="Objetos/objeto_amarillo.png", position = game.at(4,10))

const objetoRojo = new LiquidoRojo(image="Objetos/objeto_rojo.png", position = game.at(10,9))

const objetoColeccionable1 = new ObjetoColeccionable(image="chili.png", position=game.at(10,8), posicionDestino=game.at(0,5))
const objetoColeccionable2 = new ObjetoColeccionable(image="orange.png", position=game.at(10,8), posicionDestino=game.at(0,6))
const objetoColeccionable3 = new ObjetoColeccionable(image="Strawberry.png", position=game.at(10,8), posicionDestino=game.at(0,7))
const objetoColeccionable4 = new ObjetoColeccionable(image="watermelon.png", position=game.at(10,8), posicionDestino=game.at(0,8))
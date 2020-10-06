import jugadores.*
import wollok.game.*
import mapas.mapa.*

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

class Poder inherits Objeto{
	
	override method aparecer() {
		const x = (mapa.bordeIzquierdo()+1).randomUpTo(mapa.bordeDerecho()-1)
		const y = (mapa.bordeInferior()+1).randomUpTo(mapa.bordeSuperior()-1)
		position = game.at (x, y)
		super()
	}
	
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
		jugador.contrincante().quedarseQuieto(10000)
		super(jugador)
	}
}

class LiquidoVerde inherits Poder {

	override method crearReplica(direccion){
		return new LiquidoVerde(image="Objetos/objeto_amarillo.png", position = direccion)
	}
}

class LiquidoRojo inherits Poder {
	override method crearReplica(direccion){
		return new LiquidoRojo(image="Objetos/objeto_rojo.png", position = direccion)
	}
	
	override method usar(jugador){
		if(jugador.esAgente()){
			jugador.recuperarVida()
		}
	}

}

class Bomba {
	
}

class Martillo inherits Objeto {
	method construir(){
		
	}
}


const vida1 = new Objeto(image = "Objetos/vida.png", position = game.at(0,13))

const vida2 = new Objeto(image = "Objetos/vida.png", position = game.at(0,12))

const vida3 = new Objeto(image = "Objetos/vida.png", position = game.at(0,11))

const objetoAzul = new LiquidoAzul(image="Objetos/objeto_azul.png", position = game.at(14,5))

const objetoVerde = new LiquidoVerde(image="Objetos/objeto_amarillo.png", position = game.at(4,10))

const objetoRojo = new LiquidoRojo(image="Objetos/objeto_rojo.png", position = game.at(10,9))


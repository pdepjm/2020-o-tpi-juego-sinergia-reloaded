import jugadores.*
import wollok.game.*
import mapas.mapa.*

class Objeto {
	var property image
	var property position

	method aparecer() {
		const x = (mapa.bordeIzquierdo()-1).randomUpTo(mapa.bordeDerecho()-1).truncate(0)
		const y = mapa.bordeInferior().randomUpTo(mapa.bordeSuperior()).truncate(0)
		position = game.at (x, y)
		game.addVisual(self)
	}
	
	method crearReplica(direccion){return new Objeto()}
	
	method atrapado(){
		self.desaparecer()
		self.aparecer()
	}
	
	method desaparecer() {
		game.removeVisual(self)
	}
	
	method usar(jugador) {
		self.desaparecer()
	}	
}

class LiquidoAzul inherits Objeto {
	
	override method crearReplica(direccion){
		return new LiquidoAzul(image="objeto_azul.png", position = direccion)
	}
	
	override method usar(jugador){
		jugador.contrincante().quedarseQuieto(10000)
		super(jugador)
	}
}

class LiquidoVerde inherits Objeto {

	override method crearReplica(direccion){
		return new LiquidoVerde(image="objeto_amarillo.png", position = direccion)
	}
}

class LiquidoRojo inherits Objeto {
	override method crearReplica(direccion){
		return new LiquidoRojo(image="objeto_rojo.png", position = direccion)
	}
	
	override method usar(jugador){
		if(jugador.esAgente()){
			jugador.recuperarVida()
		}
	}

}

class Bomba {
	
}

const objetoAzul = new LiquidoAzul(image="objeto_azul.png", position = game.at(14,5))

const objetoVerde = new LiquidoVerde(image="objeto_amarillo.png", position = game.at(4,10))

const objetoRojo = new LiquidoRojo(image="objeto_rojo.png", position = game.at(10,9))


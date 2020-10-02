import objetos.*
import habilidades.*
import wollok.game.*

class Jugador{

	var property position = game.center()

	const objetoPropio = true
	const objetoEncontrado = true
	const puedeConstruir = true
	
	method usarObjeto() = objetoEncontrado.usar()
	
	method construir(){
		
		if (puedeConstruir) {
			objetoPropio.construir()
			// agregar cooldown
		}
		else {
			game.say(self,"No puedo construir todavía")
		}
	}
	
// sería igual que construir pero con otro metodo para el martillo asi que hay que abstraer la logica
//	method destruir() = 


}

class Agente inherits Jugador{
	method image() = "agente.png"
	 
}

class Villano inherits Jugador{
	method image() = "villano.png"
}


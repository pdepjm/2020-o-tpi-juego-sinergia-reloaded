import wollok.game.*
import jugadores.*
import villano.*
import agente.*

object teclas{
	
	method configurar(){
		
		// Mover Personaje 1
		keyboard.w().onPressDo({villano.moverseA("up")})
		keyboard.d().onPressDo({villano.moverseA("right")})
		keyboard.s().onPressDo({villano.moverseA("down")})
		keyboard.a().onPressDo({villano.moverseA("left")})
		// Habilidades y Objetos Personaj 1
		keyboard.e().onPressDo({villano.construir()})	
		keyboard.q().onPressDo({villano.usarObjeto()})
		
		// Mover Personaje 2
		keyboard.up().onPressDo({agente.moverseA("up")})	
		keyboard.right().onPressDo({agente.moverseA("right")})	
		keyboard.down().onPressDo({agente.moverseA("down")})		
		keyboard.left().onPressDo({agente.moverseA("left")})		
		// Habilidades y Objetos Personaj 2
		keyboard.l().onPressDo ({agente.construir()})
		keyboard.k().onPressDo ({agente.usarObjeto()})	
		
		}
	method desconfigurar(jugador){
		jugador.quieto()
	}
		
}

	

import wollok.game.*
import jugadores.*

object teclas{
	
	method configurar(){
		
		// Mover Personaje 1
		keyboard.e().onPressDo({villano.moverseA("up")})
		keyboard.f().onPressDo({villano.moverseA("right")})
		keyboard.d().onPressDo({villano.moverseA("down")})
		keyboard.s().onPressDo({villano.moverseA("left")})
		// Habilidades y Objetos Personaj 1
		//keyboard.w().onPressDo(villano.construir())	
		keyboard.q().onPressDo({villano.usarObjeto()})
		
		// Mover Personaje 2
		keyboard.up().onPressDo({agente.moverseA("up")})	
		keyboard.right().onPressDo({agente.moverseA("right")})	
		keyboard.down().onPressDo({agente.moverseA("down")})		
		keyboard.left().onPressDo({agente.moverseA("left")})		
		// Habilidades y Objetos Personaj 2
		//keyboard.l().onPressDo (agente.construir())
		//keyboard.k().onPressDo {  }	
		
		}
	
	method desconfigurar(personaje){
		if(personaje == villano){
			keyboard.e().onPressDo({villano.moverseA(villano.position())})
			keyboard.f().onPressDo({villano.moverseA(villano.position())})
			keyboard.d().onPressDo({villano.moverseA(villano.position())})
			keyboard.s().onPressDo({villano.moverseA(villano.position())})
		} else {
			keyboard.up().onPressDo({agente.moverseA(agente.position())})	
			keyboard.right().onPressDo({agente.moverseA(agente.position())})	
			keyboard.down().onPressDo({agente.moverseA(agente.position())})		
			keyboard.left().onPressDo({agente.moverseA(agente.position())})		
		}
	}
		
}

	

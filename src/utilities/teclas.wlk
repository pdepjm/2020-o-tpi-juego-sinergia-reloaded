import wollok.game.*
import jugadores.*
import villano.*
import agente.*
import utilities.pantalla.*
import utilities.direcciones.*

object teclas{
	var property control = true
	
	method configurar(){
		if (control) {
					// Mover Personaje 1
		keyboard.w().onPressDo({villano.moverseA(up)})
		keyboard.d().onPressDo({villano.moverseA(right)})
		keyboard.s().onPressDo({villano.moverseA(down)})
		keyboard.a().onPressDo({villano.moverseA(left)})
		// Habilidades y Objetos Personaj 1
		keyboard.e().onPressDo({villano.modificarMapa()})	
		keyboard.q().onPressDo({villano.usarObjeto()})
		
		// Mover Personaje 2
		keyboard.up().onPressDo({agente.moverseA(up)})	
		keyboard.right().onPressDo({agente.moverseA(right)})	
		keyboard.down().onPressDo({agente.moverseA(down)})		
		keyboard.left().onPressDo({agente.moverseA(left)})		
		// Habilidades y Objetos Personaj 2
		keyboard.l().onPressDo ({agente.modificarMapa()})
		keyboard.k().onPressDo ({agente.usarObjeto()})	
		}
	}
	
	method desconfigurar(jugador){
		jugador.quieto()
	}
	
	method inhabilitar_teclas(){
		control = false
	}
	
	method configurar_anexo(){
		// iniciar a jugar
		keyboard.enter().onPressDo({pantallaIntro.accionar()})	
		keyboard.i().onPressDo({comandos_game.accionar()})	
		//keyboard.p().onPressDo({play_again.accionar()})	
		keyboard.o().onPressDo({exit_game.accionar()})	
	}
		
}

	

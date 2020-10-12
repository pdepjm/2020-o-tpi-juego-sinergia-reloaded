import objetos.*
import wollok.game.*
import utilities.teclas.*
import utilities.aleatorio.*
import mapas.mapa.*
import jugadores.*
import agente.*


object villano inherits Jugador(name = "villano"){
	const property contrincante = agente
	
	method esAgente() = false
	
	override method posicionPoder() = game.at(24,2)
	
	override method posicionMartillo() = game.at(24,3)
	
	override method positionInicial(){
		position = game.at(6,7)
	}
	
	method interactuar(){
		self.quedarseQuieto(3000)
		agente.atrapado()
		game.say(self, "Una vida menos jajaja")
	}
	
	method usarObjetoRojo(){
		const direccion = ultimaDireccion.proximo(self)
		if(ultimaDireccion.posicionHabilitada(direccion)){
			const bomba = new Pinches(image = "Objetos/pinches.png", position = direccion)
			game.addVisual(bomba) 
		} else {
			game.say(self, "No puedo poner una bomba ahi")
		}
	}
	
	method usarObjetoVerde(){
		agente.perderColeccionable()
	}
}


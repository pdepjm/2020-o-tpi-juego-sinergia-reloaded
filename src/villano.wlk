import objetos.*
import wollok.game.*
import mapas.mapa.*
import jugadores.*
import agente.*
import utilities.teclas.*
import utilities.aleatorio.*
import utilities.teclas.*
import utilities.pantalla.*


object villano inherits Jugador(name = "villano"){
	const property contrincante = agente
	const property mensajes = [	"Congelá a tu oponente",
								"Colocá una trampa",
								"Arrebata un objeto de tu oponente" ]
	
	method esAgente() = false
	
	override method posicionPoder() = game.at(4,15)
	
	override method posicionMartillo() = game.at(3,15)
	
	override method positionInicial(){
		self.cambiarPosicion(game.at(6,7))
	}
	
	method interactuar(){
		self.quedarseQuieto(3000)
		agente.atrapado()
		game.say(self, "Una vida menos jajaja")
	}
	
	method usarObjetoRojo(){
		const direccion = self.ultimaDireccion().proximo(self)
		if(game.getObjectsIn(direccion).isEmpty()){
			const bomba = new Pinches(image = "Objetos/pinches.png", position = direccion)
			game.addVisual(bomba) 
			
		} else {
			game.say(self, "No puedo poner una bomba ahi")
		}
		return bomba
	}
	
	method usarObjetoVerde(){
		agente.perderColeccionable()
	}
	
}


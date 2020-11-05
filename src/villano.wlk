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
	
	override method posicionPoder() = game.at(4,15)
	
	override method posicionMartillo() = game.at(3,15)
	
	override method positionInicial(){
		self.cambiarPosicion(game.at(6,7))
	}
	
	override method esAgente() = false
	
	method interactuar(){
		self.quedarseQuieto(3000)
		agente.atrapado()
		game.say(self, "Una vida menos jajaja")
	}
	
	method usarObjetoRojo(){
		const direccion = self.ultimaDireccion().proximo(self)
		if(game.getObjectsIn(direccion).isEmpty()){
			const bomb = game.sound("Musica/bomb.mp3")
			const bomba = new Pinches(image = "Objetos/pinches.png", position = direccion)
			game.addVisual(bomba) 
			bomb.play()
			
		} else {
			game.say(self, "No puedo poner una bomba ahi")
		}
		return bomba
	}
	
	method usarObjetoVerde(){
		agente.perderColeccionable()
	}
	
}


import objetos.*
import wollok.game.*
import utilities.teclas.*
import utilities.aleatorio.*
import mapas.mapa.*
import jugadores.*
import agente.*


object villano inherits Jugador{
	const property contrincante = agente
	var property image =  "Personajes/villano_adelante.png"
	
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
	
	override method cambiarImagen(direccion){
		if(direccion == "up"){
			image = "Personajes/villano_back.png"
		} else if (direccion == "right"){
			image = "Personajes/villano_back.png"
		} else if (direccion == "down"){
			image = "Personajes/villano_adelante.png"
		} else if (direccion == "left"){
			image = "Personajes/villano_adelante.png"
		}
	}
	
	method ponerPinches(){
		const bomba = new Pinches(image = "Objetos/pinches.png", position = self.posicionAModificar())
		game.addVisual(bomba) 
	}
}


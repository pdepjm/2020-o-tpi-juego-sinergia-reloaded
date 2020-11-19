import wollok.game.*
import objetos.*
import mapas.mapa.*
import jugadores.*
import villano.*
import utilities.teclas.*
import utilities.aleatorio.*
import utilities.pantalla.*

object agente inherits Jugador(name = "agente"){
	const property contrincante = villano
	var property cantidadDeVidas = 3
	const property objetosColeccionados = []
	const property mensajes = [	"Congelá a tu oponente",
								"Recupera una vida",
								"Activa Telestrasportarse"]
	
	override method posicionPoder() = game.at(23,15)
	
	override method posicionMartillo() = game.at(22,15)
	
	override method positionInicial(){
		self.cambiarPosicion(game.at(20,6))
	}
	
	override method iniciar(){
		super()
		vidas.mostrar()
	}
	
	override method esAgente() = true
	
	method atrapado() {
		self.perderVida()
	}
	
	method perderVida() {
		game.sound("Musica/auch.mp3").play()
		vidas.sacar()
		game.say(self, "Auch")
		cantidadDeVidas -= 1
		if(cantidadDeVidas == 0){
			self.inmovilizar()
			game.say(villano, "Yo gano hoy, suerte la proxima campeon")
			game.schedule(500, {game.sound("Musica/game_over.mp3").play()})
			game.schedule(3000, { game.removeTickEvent("reloj") gameOver.control(false) gameOver.accionar(villano)})
		}
	}	

		
	/////////////////////////////
	//- OBJETOS COLECCIONABLES-//
	/////////////////////////////	
	method usarObjetoRojo(){
		if(cantidadDeVidas < 3){
			cantidadDeVidas+=1
			vidas.agregar()
		} else {
			game.say(self, "Ya tenes todas las vidas capo")
		}
	}

	method usarObjetoVerde(){
		game.removeVisual(self) 
		self.positionInicial()
		game.addVisual(self)
	}
		
	method perderColeccionable() {
		
		if(objetosColeccionados.isEmpty()){
			game.say(villano, "El pobre ya no tiene objetos que perder")
		}
		else {
			const objetoPerdido = objetosColeccionados.last()
			objetosColeccionados.remove(objetoPerdido)
			objetoPerdido.reaparecer()
		}		
	}
	
	method guardarColeccionable(coleccionable){ 
		objetosColeccionados.add(coleccionable)
		if(objetosColeccionados.size() == 4){
			villano.inmovilizar()
			game.sound("Musica/cheers.mp3").play()
			game.say(self, "Yo gano hoy, suerte la proxima campeon")
			game.schedule(100, { game.removeTickEvent("reloj") gameOver.control(false) gameOver.accionar(self)})
		} else {
			game.say(self, "Faltan "+ self.objetosRestantesPorColeccionar().toString() + " objetos por recolectar")
		}
	}
	
	method objetosRestantesPorColeccionar() = 4 - objetosColeccionados.size()
}
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
								"Activa Telestrasportarse",
								"Faltan "+ self.objetosRestantesPorColeccionar().toString() + " objetos por recolectar" ]
	
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
		vidas.sacar()
		game.say(self, "Auch")
		cantidadDeVidas -= 1
		if(cantidadDeVidas == 0){
			game.say(villano, "Yo gano hoy, suerte la proxima campeon")
			game.schedule(1000, { game.removeTickEvent("reloj") gameOver.control(false) gameOver.accionar(villano)})
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
		game.say(self, "Faltan "+ self.objetosRestantesPorColeccionar().toString() + " objetos por recolectar")
		if(objetosColeccionados.size() == 4){
			game.say(self, "Yo gano hoy, suerte la proxima campeon")
			game.schedule(100, { game.removeTickEvent("reloj") gameOver.control(false) gameOver.accionar(self)})
		}
	}
	
	method objetosRestantesPorColeccionar() = 4 - objetosColeccionados.size()
}
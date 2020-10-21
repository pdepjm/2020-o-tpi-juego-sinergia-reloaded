import objetos.*
import wollok.game.*
import utilities.teclas.*
import utilities.aleatorio.*
import mapas.mapa.*
import jugadores.*
import villano.*

object agente inherits Jugador(name = "agente"){
	const property contrincante = villano
	var property cantidadDeVidas = 3
	const property objetosColeccionados = []
	
	method esAgente() = true
	
	override method posicionPoder() = game.at(23,15)
	
	override method posicionMartillo() = game.at(22,15)
	
	override method positionInicial(){
		position = game.at(20,6)
	}
	
	override method iniciar(){
		super()
		vidas.mostrar()
	}
	
	
	method atrapado() {
		self.perderVida()
	}
	
	method perderVida() {
		vidas.sacar()
		cantidadDeVidas -= 1
		if(cantidadDeVidas == 0){
			game.say(villano, "Yo gano hoy, suerte la proxima campeon")
			game.schedule(3000, {game.stop()})
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
		position = aleatorio.nuevaPosicion()}
		
	method perderColeccionable() {
		
		if(objetosColeccionados.isEmpty()){
			game.say(villano, "El pobre ya no tiene objetos que perder")
		}
		else {
			const objetoPerdido =objetosColeccionados.last()
			objetosColeccionados.remove(objetoPerdido)
			objetoPerdido.reaparecer()
		}		
	}
	
	method guardarColeccionable(coleccionable){ 
		objetosColeccionados.add(coleccionable)
		if(objetosColeccionados.size() == 4){
			game.say(self, "Yo gano hoy, suerte la proxima campeon")
			game.schedule(3000, {game.stop()})
			}
		}
}




import objetos.*
import wollok.game.*
import utilities.teclas.*
import utilities.aleatorio.*
import mapas.mapa.*
import jugadores.*
import villano.*

object agente inherits Jugador(name = "agente"){
	const property contrincante = villano
	var cantidadDeVidas = 3
	const objetosColeccionados = []
	
	method esAgente() = true
	
	override method posicionPoder() = game.at(0,2)
	
	override method posicionMartillo() = game.at(0,3)
	
	override method iniciar(){
		super()
		vidas.mostrar()
	}
	
	
	
	override method positionInicial(){
		position = game.at(20,6)
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
	

	method usarObjetoRojo(){
		if(cantidadDeVidas < 3){
			cantidadDeVidas+=1
			vidas.agregar()
		} else {
			game.say(self, "Ya tenes todas las vidas capo")
		}
	}	
	
	
	method guardarColeccionable(coleccionable){ 
		objetosColeccionados.add(coleccionable)
		if(objetosColeccionados.size() == 4){
			game.say(self, "Yo gano hoy, suerte la proxima campeon")
			game.schedule(3000, {game.stop()})
			}
		}
		
	

	method usarObjetoVarde(){
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
}

object vidas {
	const lista = [vida1, vida2, vida3]
	const ultimaVidaSacada = []
	
	method sacar(){
		const ultimaVida = lista.last()
		game.removeVisual(ultimaVida)
		ultimaVidaSacada.add(ultimaVida)
		lista.remove(ultimaVida)
	}
	
	method agregar(){
		if(!ultimaVidaSacada.isEmpty()){
			const agregar = ultimaVidaSacada.last()
			game.addVisual(agregar)
			ultimaVidaSacada.remove(agregar)
		}
	}
	
	method mostrar(){
		lista.forEach({vida => game.addVisual(vida)})
	}
}

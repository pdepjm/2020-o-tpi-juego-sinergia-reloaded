import objetos.*
import wollok.game.*
import utilities.teclas.*
import utilities.aleatorio.*
import mapas.mapa.*
import jugadores.*
import villano.*

object agente inherits Jugador(name = "agente"){
	const property contrincante = villano
	const vidas = [vida1, vida2, vida3]
	const objetosColeccionados = []
	
	method esAgente() = true
	
	override method posicionPoder() = game.at(0,2)
	
	override method posicionMartillo() = game.at(0,3)
	
	override method iniciar(){
		super()
		self.mostrarVidas()
	}
	
	method mostrarVidas(){
		vidas.forEach({vida => game.addVisual(vida)})
	}
	
	override method positionInicial(){
		position = game.at(20,6)
	}
	
	method atrapado() {
		self.perderVida()
	}
	
	method perderVida() {
		const ultimaVida = vidas.last()
		game.removeVisual(ultimaVida)
		vidas.remove(ultimaVida)
		if(vidas.isEmpty()){
			game.say(villano, "Yo gano hoy, suerte la proxima campeon")
			game.schedule(3000, {game.stop()})
		}
	}	
	
	//  agregar contador de vidas
	method usarObjetoRojo(){
		if(vidas.size() == 1){
			vidas.add(vida2)
			game.addVisual(vida2)
		} else if (vidas.size()==2){
			vidas.add(vida3)
			game.addVisual(vida3)
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

import objetos.*
import wollok.game.*
import utilities.teclas.*
import mapas.mapa.*

class Jugador{
	var property position = game.center()
	var objetoEncontrado = null
	var property posicionPoder
	var property posicionMartillo
	var property positionInicial
	var puedeConstruir = true
	var movimientosHabilitados = true
	
	const martillo = new Martillo(image = "Objetos/martillo.png", position = self.posicionMartillo())
	
	method iniciar(){
		self.positionInicial()
		self.habilitarConstruccion()
	}
	
	method usarObjeto(){
		objetoEncontrado.usar(self)
		objetoEncontrado = null
	}
	method construir(){
		
		if (puedeConstruir) {
			martillo.construir()
			puedeConstruir = false
			martillo.desaparecer()
			//schedule(15000, {self.habilitarConstruccion()})
		}
		else {
			game.say(self,"No puedo construir todavía")
		}
	}
	
	method habilitarConstruccion(){
		puedeConstruir = true
		martillo.aparecer()
	}
	
	method nuevaPosicion(direccion){
		if(movimientosHabilitados){
			if (direccion == "up" && position.y()+1 < mapa.bordeSuperior()){
				return self.position().up(1)
			}
			if (direccion == "down" && position.y()-1 > mapa.bordeInferior()){
				return self.position().down(1)
			}
			if (direccion == "right" && position.x()+1 < mapa.bordeDerecho()){
				return self.position().right(1)
			} 
			if (direccion == "left" && position.x()-1 > mapa.bordeIzquierdo()){
				return self.position().left(1)
			}
		}
		
		return position

	}
	
	method cambiarImagen(direccion){}
	
	method moverseA(direccion){
		self.cambiarImagen(direccion)
		position = self.nuevaPosicion(direccion)
	}
	
	method quedarseQuieto(milisegundos){
		movimientosHabilitados = false
		//schedule(milisegundo, {movimientosHabilitados = true})
	}
	
	method guardarObjeto(objeto){
		if(objetoEncontrado != null){
			game.removeVisual(objetoEncontrado)
		} 
		objetoEncontrado = objeto.crearReplica(self.posicionPoder())
		game.addVisual(objetoEncontrado)
		objeto.atrapado()
	}
	
// sería igual que construir pero con otro metodo para el martillo asi que hay que abstraer la logica
//	method destruir() = 


}

object agente inherits Jugador{
	const property contrincante = villano
	var vidas = [vida1, vida2, vida3]
	var property image = "Personajes/agente_adelante.png"
	
	method esAgente() = true
	
	override method posicionPoder() = game.at(0,5)
	
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
		villano.atrapar()
	}
	
	method perderVida() {
		const ultimaVida = vidas.last()
		game.removeVisual(ultimaVida)
		vidas.remove(ultimaVida)
		if(vidas.isEmpty()){
			game.say(villano, "Suerte la proxima campeon")
			game.schedule(3000, {game.stop()})
		}
	}	
	
	method recuperarVida(){
		if(vidas.size() == 1){
			vidas.add(vida2)
			game.addVisual(vida2)
		} else if (vidas.size()==2){
			vidas.add(vida3)
			game.addVisual(vida3)
		}
	}	
	
	
	override method cambiarImagen(direccion){
		if(direccion == "up"){
			image = "Personajes/agente_back.png"
		} else if (direccion == "right"){
			image = "Personajes/agente_der.png"
		} else if (direccion == "down"){
			image = "Personajes/agente_adelante.png"
		} else if (direccion == "left"){
			image = "Personajes/agente_izq.png"
		}
	}
}

object villano inherits Jugador{
	const property contrincante = agente
	var property image =  "Personajes/villano_adelante.png"
	
	method esAgente() = false
	
	override method posicionPoder() = game.at(24,5)
	
	override method posicionMartillo() = game.at(24,3)
	
	override method positionInicial(){
		position = game.at(6,7)
	}
	
	method atrapar(){
		self.quedarseQuieto(3000)
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
}


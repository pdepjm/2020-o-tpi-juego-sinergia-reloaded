import objetos.*
import habilidades.*
import wollok.game.*
import utilities.teclas.*
import mapas.mapa.*

class Jugador{
	var property position = game.center()
	var objetoEncontrado = null
	var property posicionPoder
	var puedeConstruir = true
	var movimientosHabilitados = true
	const martillo = new Martillo()
	
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
	var vidas = 3
	var property image = "Personajes/agente_adelante.png"
	
	method esAgente() = true
	
	override method posicionPoder() = game.at(0,5)
	
	method positionInicial(){
		position = game.at(20,6)
	}
	
	method atrapado() {
		self.perderVida()
		villano.atrapar()
	}
	
	method perderVida() {
		vidas -= 1
		if(vidas == 0){
			game.say(villano, "Suerte la proxima campeon")
			game.schedule(5000, {game.stop()})
		}
	}	
	
	method recuperarVida(){
		if(vidas < 3){
			vidas += 1
		}
	}	
	
	override method habilitarConstruccion(){
		super()
		game.addVisualIn(martillo, game.at(0,1))
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
	
	override method habilitarConstruccion(){
		super()
		game.addVisualIn(martillo, game.at(24,1))
	}
	
	method positionInicial(){
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


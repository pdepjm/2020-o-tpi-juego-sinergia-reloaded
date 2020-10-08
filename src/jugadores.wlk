import objetos.*
import wollok.game.*
import utilities.teclas.*
import utilities.aleatorio.*
import mapas.mapa.*

class Jugador{
	var property position = game.center()
	var objetoEncontrado = null
	var property posicionPoder
	var property posicionMartillo
	var property positionInicial
	var ultimaDireccion = "down"
	var puedeConstruir = true
	var movimientosHabilitados = true
	
	
	const martillo = new Martillo(image = "Objetos/martillo.png", position = self.posicionMartillo())
	
	method iniciar(){
		self.positionInicial()
		self.habilitarConstruccion()
	}
	
	method usarObjeto(){
		if(objetoEncontrado!= null){
		objetoEncontrado.usar(self)
		objetoEncontrado = null
		}
		else {game.say(self,"No tengo ningún objeto")}
	}
	
	method construir(){
		if (puedeConstruir) {
			martillo.construir(self)
			puedeConstruir = false
			martillo.desaparecer()
			game.schedule(15000, {self.habilitarConstruccion()})
			
		}
		else {
			game.say(self,"No puedo construir todavía")
			
		}
	}
	
	method habilitarConstruccion(){
		puedeConstruir = true
		martillo.aparecer()
	}

// direccion -> objeto, se eliminan ifs

	method nuevaPosicion(direccion){
		if(movimientosHabilitados){
			if (direccion == "up" && position.y()+1 < mapa.bordeSuperior()){
				ultimaDireccion = "up"
				return self.position().up(1)
			}
			if (direccion == "down" && position.y()-1 > mapa.bordeInferior()){
				ultimaDireccion = "down"
				return self.position().down(1)
			}
			if (direccion == "right" && position.x()+1 < mapa.bordeDerecho()){
				ultimaDireccion = "right"
				return self.position().right(1)
			} 
			if (direccion == "left" && position.x()-1 > mapa.bordeIzquierdo()){
				ultimaDireccion = "left"
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
		game.schedule(milisegundos, {=>movimientosHabilitados = true})
	}
	
	method guardarObjeto(objeto){
		if(objetoEncontrado != null){
			game.removeVisual(objetoEncontrado)
		} 
		objetoEncontrado = objeto.crearReplica(self.posicionPoder())
		game.addVisual(objetoEncontrado)
		objeto.atrapado()
	}
	
	method posicionAModificar(){
		if (ultimaDireccion == "up"){
			return position.up(1)
		} else if (ultimaDireccion == "down"){
			return position.down(1)
		} else if (ultimaDireccion == "right"){
			return position.right(1)
		}
		return position.left(1)
	}

}

import objetos.*
import wollok.game.*
import utilities.teclas.*
import utilities.aleatorio.*
import mapas.mapa.*
import utilities.direcciones.*

class Jugador{
	var property position = game.center()
	var objetoEncontrado = null
	var property posicionPoder
	var property posicionMartillo
	var property positionInicial
	var property ultimaDireccion = down
	var puedeConstruir = true
	var movimientosHabilitados = true
	var name	
	var property image
	
	const martillo = new Martillo(image = "Objetos/martillo.png", position = self.posicionMartillo())
	
	method iniciar(){
		self.actualizarImagen()
		game.addVisual(self)
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
	
	method modificarMapa(){
		if (puedeConstruir && ultimaDireccion.dentroDeLosLimites(ultimaDireccion.proximo(self))) {
			martillo.modificarMapa(self)
			puedeConstruir = false
			martillo.desaparecer()
			game.schedule(10000, {self.habilitarConstruccion()})
		}
		else {
			game.say(self,"No puedo construir")
		}
	}
	
	method habilitarConstruccion(){
		puedeConstruir = true
		martillo.aparecer()
	}


	method moverseA(direccion){
		ultimaDireccion = direccion
		self.actualizarImagen()
		if (movimientosHabilitados){
			position = direccion.posicionMirada(self)
		}
	}
	
	method actualizarImagen(){
		image = "Personajes/" + name + "_" + ultimaDireccion.name() +".png"
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
	
}

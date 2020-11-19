import objetos.*
import wollok.game.*
import utilities.teclas.*
import mapas.mapa.*
import paredes.*
import utilities.direcciones.*
import utilities.aleatorio.*

class Jugador{
	var property position = game.center()
	var property posicionPoder
	var property posicionMartillo
	var property positionInicial
	var property ultimaDireccion = down
	var property image
	var objetoEncontrado = null
	var puedeConstruir = true
	var property movimientosHabilitados = true
	var name	
	
	const martillo = new Martillo(image = "Objetos/martillo.png", position = self.posicionMartillo())
	
	method position(nuevaPosition){ position = nuevaPosition}
	method name() = name
	
	method iniciar(){
		self.actualizarImagen()
		game.addVisual(self)
		self.positionInicial()
		self.habilitarConstruccion()
	}
	
	method esAgente()
	
	method usarObjeto(){
		if(objetoEncontrado!= null){
		objetoEncontrado.usar(self)
		objetoEncontrado = null
		}
		else {game.say(self,"No tengo ningún objeto")}
	}
	
	method modificarMapa(){
		if (puedeConstruir && ultimaDireccion.dentroDeLosLimites(ultimaDireccion.proximo(self)) && laberinto.celda_disponible(ultimaDireccion.proximo(self))) {
			martillo.modificarMapa(self)
			puedeConstruir = false
			martillo.desaparecer()
			game.schedule(5000, {self.habilitarConstruccion()})
		}
		else 
			game.say(self, "WARNING:  no es posible realizar la accion")
	}
	
	method habilitarConstruccion(){
		puedeConstruir = true
		martillo.aparecer()
	}


	method moverseA(direccion){
		ultimaDireccion = direccion
		self.actualizarImagen()
		if (movimientosHabilitados)
			position = direccion.posicionMirada(self)
	}
	
	method actualizarImagen(){
		image = "Personajes/" + name + "_" + ultimaDireccion.name() +".png"
	}
	
	method quedarseQuieto(milisegundos){
		self.inmovilizar()
		game.schedule(milisegundos, {=>movimientosHabilitados = true})
	}
	
	method inmovilizar(){
		movimientosHabilitados = false
	}
	
	method guardarObjeto(objeto){
		if(objetoEncontrado != null){
			game.removeVisual(objetoEncontrado)
		} 
		objetoEncontrado = objeto.crearReplica(self.posicionPoder())
		game.addVisual(objetoEncontrado)
		objeto.atrapado()
		return objetoEncontrado
	}
	
	method cambiarPosicion(nueva){
		position = nueva
	}
}

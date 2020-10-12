import mapas.mapa.*
import jugadores.*
import paredes.*

class Direccion {
	const property name
	method posicionHabilitada(posicion) = self.dentroDeLosLimites(posicion) && paredes.posicionDisponible(posicion)
	
	method posicionMirada(jugador){
		 const nuevaDireccion = self.proximo(jugador)
		 if(self.posicionHabilitada(nuevaDireccion)){
		 	return nuevaDireccion
		 }
		 return jugador.position()
	}
	
	method dentroDeLosLimites(direccion) = true
	method proximo(jugador) = jugador.position()
	
}

object up inherits Direccion(name = "back"){

	override method proximo(jugador) = jugador.position().up(1)
	
	override method dentroDeLosLimites(posicion) = posicion.y() < mapa.bordeSuperior()
}

object down inherits Direccion(name = "adelante"){

	override method proximo(jugador) = jugador.position().down(1)
	
	override method dentroDeLosLimites(posicion) = posicion.y() > mapa.bordeInferior()
}

object left inherits Direccion (name = "izq"){

	override method proximo(jugador) = jugador.position().left(1)
	
	override method dentroDeLosLimites(posicion) = posicion.x() > mapa.bordeIzquierdo()
	
}

object right inherits Direccion (name = "der"){
	
	override method proximo(jugador) = jugador.position().right(1)
	
	override method dentroDeLosLimites(posicion) = posicion.x() < mapa.bordeDerecho()
	
}

import mapas.mapa.*
import jugadores.*

class Direccion {
	method posicionMirada (jugador){
		var nuevaPosicion = self.nuevaPosicion(jugador)
		return nuevaPosicion
	}
	method nuevaPosicion(jugador) {
		return jugador.position()
	}
		
}

object up inherits Direccion{
	const property name = "back"
	override method nuevaPosicion(jugador){
		if(self.posicionHabilitada(jugador))
		 	return jugador.position().up(1);

		return jugador.position()
	}
	method posicionHabilitada(jugador) = jugador.position().y()+1 < mapa.bordeSuperior()
}

object down inherits Direccion{
	const property name = "adelante"
	override method nuevaPosicion(jugador){
		 if(self.posicionHabilitada(jugador)){
		 	return jugador.position().down(1);
		 }
		 return jugador.position();
	}
	method posicionHabilitada(jugador) = jugador.position().y()-1 > mapa.bordeInferior()
	
}

object left inherits Direccion{
	const property name = "izq"
	override method nuevaPosicion(jugador){
		 if(self.posicionHabilitada(jugador)){
		 	return jugador.position().left(1);
		 }
		 return jugador.position();
	}
	method posicionHabilitada(jugador) = jugador.position().x()-1 > mapa.bordeIzquierdo()
	
}

object right inherits Direccion{
	const property name = "der"
	override method nuevaPosicion(jugador){
		 if(self.posicionHabilitada(jugador)){
		 	return jugador.position().right(1);
		 }
		 return jugador.position();
	}
	
	method posicionHabilitada(jugador) = jugador.position().x()+1 < mapa.bordeDerecho()
	
}

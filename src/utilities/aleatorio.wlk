import wollok.game.*
import mapas.mapa.*
import paredes.*

object aleatorio {
	// var posicion
	method get_position(){
		const x = (mapa.bordeIzquierdo()+1).randomUpTo(mapa.bordeDerecho()-1)
		const y = (mapa.bordeInferior()+1).randomUpTo(mapa.bordeSuperior()-1)
		
		return game.at(x, y)
	}									

	
	method nuevaPosicion() {
		self.get_position()
		
		if(laberinto.celda_disponible(posicion)) // (not) preguntar si hay algo en la celda
			return posicion
		else{
			// posicion.clear()
			return self.nuevaPosicion()
		}
			
	}

}
import wollok.game.*
import mapas.mapa.*
import paredes.*

object aleatorio {
	var posicion
	method get_position(){
		const x = (mapa.bordeIzquierdo()+1).randomUpTo(mapa.bordeDerecho()-1)
		const y = (mapa.bordeInferior()+1).randomUpTo(mapa.bordeSuperior()-1)
		
		posicion = game.at(x, y)
	}									

	
	method nuevaPosicion() {
		self.get_position()
		
		if(laberinto.celda_disponible(posicion))
			return posicion
		else{
			posicion.clear()
			return self.nuevaPosicion()
		}
			
	}

}
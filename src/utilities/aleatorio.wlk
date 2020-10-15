import wollok.game.*
import mapas.mapa.*
import paredes.*

object aleatorio {
	//var posicion
	
	/*method nuevaPosicion() {
		
		const x = (mapa.bordeIzquierdo()+1).randomUpTo(mapa.bordeDerecho()-1)
		const y = (mapa.bordeInferior()+1).randomUpTo(mapa.bordeSuperior()-1)
		
		return game.at(x, y)
	}*/
	
	
	method get_position(){
		const x = (mapa.bordeIzquierdo()+1).randomUpTo(mapa.bordeDerecho()-1)
		const y = (mapa.bordeInferior()+1).randomUpTo(mapa.bordeSuperior()-1)
		
		return game.at(x, y)
	}									

	
	method nuevaPosicion() {
		const posicion = self.get_position()
		if(laberinto.celda_disponible(posicion))
			return posicion
		else
			return game.at(4,1)
	}

}
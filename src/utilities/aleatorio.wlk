import wollok.game.*
import mapas.mapa.*
import paredes.*

object aleatorio {
	
	method get_position(){
		const x = (mapa.bordeIzquierdo()+1).randomUpTo(mapa.bordeDerecho()-1)
		const y = (mapa.bordeInferior()+1).randomUpTo(mapa.bordeSuperior()-1)
		
		return game.at(x, y)
	}									
	
	method nuevaPosicion() {
		const position = self.get_position()
		
		if(game.getObjectsIn(position).isEmpty())
			return position
		else
			return self.nuevaPosicion()	
	}

}

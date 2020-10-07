import wollok.game.*
import mapas.mapa.*

object aleatorio {

	method nuevaPosicion() {
		
		const x = (mapa.bordeIzquierdo()+1).randomUpTo(mapa.bordeDerecho()-1)
		const y = (mapa.bordeInferior()+1).randomUpTo(mapa.bordeSuperior()-1)
		
		return game.at(x, y)
	}

}
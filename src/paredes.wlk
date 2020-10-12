import objetos.*
import wollok.game.*

class Pared inherits Objeto{
	override method guardarObjeto(objeto){
		objeto.aparecer()
	}	
}

object paredes{
	const posicionesOcupadas = new Set()
	
	method agregarPared(posicion){
		posicionesOcupadas.add(posicion)
		const pared = new Pared(image = "muro.png", position = posicion)
		pared.aparecer()
	}
	
	method posicionDisponible(posicion) = !posicionesOcupadas.contains(posicion)
	
	method sacarPared(posicion){
		posicionesOcupadas.remove(posicion)
		// No se como sacarla del juego a la pared
		// game.getObjectsIn(posicion).desaparecer()
	}
}

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
		new Pared(image = "muro.png", position = posicion).aparecer()
	}
	
	method posicionDisponible(posicion) = !posicionesOcupadas.contains(posicion)
	
	/*method sacarPared(posicion){
		posicionesOcupadas.remove(posicion)
		game.removeVisual(game.getObjectsIn(posicion))
	}*/
}

